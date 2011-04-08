From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 8 Apr 2011 17:36:03 +0200
Message-ID: <4D9F2B63.9010507@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>	 <1301489930.15095.51.camel@deskari>	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>	 <1301900022.2715.12.camel@deskari>	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com> <1302241893.2102.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52975 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932317Ab1DHPgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Apr 2011 11:36:19 -0400
In-Reply-To: <1302241893.2102.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Tomi,

On 4/8/2011 7:51 AM, Valkeinen, Tomi wrote:
> Hi Paul,
>=20
> On Thu, 2011-04-07 at 13:27 -0600, Paul Walmsley wrote:
>> Hello Tomi, Beno=C3=AEt,
>>
>> On Mon, 4 Apr 2011, Tomi Valkeinen wrote:
>>
>>> On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
>>>
>>>> Based on the E-mail thread so far, I'd say that changing the clock=
 aliases
>>>> is the way to go for right now.  The clock aliases are not hardwar=
e data;
>>>> they just control how the clock hardware is mapped to the drivers.
>>>
>>> I'd very much prefer this option. Below is a patch for this.
>>>
>>> If Benoit doesn't complain too much about this, I'd like to get thi=
s
>>> merged as soon as possible, as OMAP4 DSS is currently crashing in t=
he
>>> mainline kernel.
>>
>> I will queue your clock aliases patch and attempt to merge it upstre=
am for
>> the -rc series.  I am not happy to be disagreeing with Beno=C3=AEt h=
ere, but
>> this is the rationale that I am using.  (Beno=C3=AEt, Tomi, please f=
eel free to
>> correct if there is something blatantly false below.)
>>
>> 1. The integration of the DSS module is an unusual case.  The
>>     MODULEMODE bits for the DSS bits do not control the DSS "main"
>>     functional clock (the clock that is needed to access device
>>     registers); instead, they only control the DSS interface clock.
>>     (This is because the DSS can use a functional clock that is not
>>     provided by the OMAP core.)  So calling the DSS MODULEMODE struc=
t
>>     clk "dss_fck" is not really correct, since it is really controll=
ing
>>     the interface clock.
>=20
> If we don't apply the patch, I think the clock aliases are still brok=
en.
> Let's forget the ick/fck thing for a second, and just think the clock
> from PRCM which is used as the source clock for pixel clock. That is
> currently called "fck" on OMAP2/3, but "dss_dss_clk" on OMAP4. This
> cannot be right, can it? From DSS's point of view that is the same
> clock, it should clearly have the same alias on all platforms. I don'=
t
> care what the name is as long as it's consistent on all platforms.
>=20
> And I have to say I still don't quite get it what is the problem with
> "fck" name. Or is that meant to be a clock which enables the register=
s
> on the module, and not the clock used for the pixel clock? If so, I'm
> fine with having "fck" to be what it is currently, but then we need a
> new name for the clock used for pixel clock, which is consistent on a=
ll
> platforms.

Both can be used for the system clock (sys_clk -> DSI DPLL or dss_dss_c=
lk).

In fact after multiple discussions with DSS and PRCM folks, I realized =
that OMAP3 and 4 are using exactly the same clock scheme :-(

The confusion in my mind came from change in naming convention in both =
the PRCM and the DSS at the same time between OMAP3 and 4.

OMAP3          -> OMAP4
dss1_alwon_fck -> dss_dss_clk (from dpll per output in both cases)
dss2_alwon_fck -> dss_sys_clk
dss_ick        -> dss_fck (-> modulemode) that name really needs to be =
changed to avoid further confusion.


So in fact the OMAP4 aliased should be:=20
CLK("omapdss_dss",	"fck",		&dss_dss_clk,	CK_443X),
CLK("omapdss_dss",	"sys_clk",	&dss_sys_clk,	CK_443X),
CLK("omapdss_dss",	"ick",		&dss_fck,	CK_443X),


That will map perfectly what we have on OMAP3:
CLK("omapdss_dss",	"fck",		&dss1_alwon_fck_3430es2, ...),
CLK("omapdss_dss",	"sys_clk",	&dss2_alwon_fck, ...),
CLK("omapdss_dss",	"ick",		&dss_ick_3430es2, ...),


>> 2. This patch does not create a precedent for hacking around general
>>     driver clocking problems in the clock or clock data.  This is on=
ly
>>     needed because the MODULEMODE bits don't control the module
>>     functional clock in this case.  As I understand it, the only oth=
er
>>     device that this problem could occur with is McBSP, due to
>>     mcbsp_clks.
>>
>> 3. The existing DSS2 driver clock design apparently works fine when
>>     this change is implemented[1], so no driver changes will be need=
ed.
>>
>> 4. The proposed DSS driver patch to work around this uses a nasty ha=
ck
>>     that really should be NACK'ed[2].
>>
>> All this said, we may not be able to merge this change upstream, due=
 to
>> the recent unhappiness about the clock data changes.  If Linus rejec=
ts it,
>> you'll need a "Plan B."
>>
>> ...
>>
>> Also, I hope you and the other DSS hackers can finish the PM runtime
>> conversion of the DSS driver soon.  Ideally before any new DSS
>> features are added.  We really need to be able to separate the OMAP
>> integration details from the drivers, and right now, hwmod and PM
>> runtime are the best way we have to do that.
>=20
> I also started to look at the PM runtime, but it doesn't fix the issu=
e
> with the inconsistent clock name I described above.

No indeed.

> I also have some questions regarding PM runtime, perhaps I'll just pu=
t
> them here as they are slightly related:
>=20
> - Should every DSS module handle their clocks independently, i.e. sho=
uld
> VENC get its own clocks and DSI should get its own? If so, we need a
> bunch of new clock aliases so the devices can get their clocks.

=46or dedicated clock like tv_clk, it probably makes sense, because the=
 other DSS drivers do not have to care about that clock.

> - Should every DSS module have their own PM runtime handling? (actual=
ly
> related to the question above)
>=20
> - If the modules are handled separately, how should the dependencies =
be
> handled? For example, dss_core's reset will reset all the other modul=
es
> also, and most of the submodules need functions from dss_core and
> dss_dispc. So should, say, dss_dsi then call functions in core and di=
spc
> to "get" them, i.e. increase their pm runtime use count?

Are you sure about that?=20
The dss_core does not have any reset in the sysonfig (only a status), b=
ut the dispc does have one and the dsi as well.
That being said, the dss modules have some issue with the softreset at =
boot time, so I'm not sure what these bits are really doing.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
