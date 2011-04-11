From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 23:29:53 +0200
Message-ID: <4DA372D1.6010508@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>  <1301900022.2715.12.camel@deskari>  <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>  <1302241893.2102.21.camel@deskari>  <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com> <1302512187.2198.44.camel@deskari> <alpine.DEB.2.00.1104110946000.22291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755879Ab1DKVaN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 17:30:13 -0400
In-Reply-To: <alpine.DEB.2.00.1104110946000.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 4/11/2011 6:05 PM, Paul Walmsley wrote:
> Hi
>
> On Mon, 11 Apr 2011, Tomi Valkeinen wrote:
>
>> On Fri, 2011-04-08 at 10:28 -0600, Paul Walmsley wrote:
>>> On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
>>>
>>>>> Also, I hope you and the other DSS hackers can finish the PM runt=
ime
>>>>> conversion of the DSS driver soon.  Ideally before any new DSS
>>>>> features are added.  We really need to be able to separate the OM=
AP
>>>>> integration details from the drivers, and right now, hwmod and PM
>>>>> runtime are the best way we have to do that.
>>>>
>>>> I also started to look at the PM runtime, but it doesn't fix the i=
ssue
>>>> with the inconsistent clock name I described above.
>>>
>>> After the hwmod/PM runtime conversion, I don't think any of the clo=
ck
>>> aliases currently in clock*_data.c should be used by the DSS driver=
 (or by
>>> anything else on the system, for that matter).  That's because the
>>> omap_device code should set up the "main" alias for the DSS main
>>
>> When should "main" clock be used by the driver? Or never, and pm_run=
time
>> handles that?
>
> If the DSS needs to change the parent or the clock rate of the main c=
lock,
> then it will need to clk_get(dev, "main") and use the clock API.  My =
only
> point here was that the "main" alias should be automatically added by=
 the
> omap_device code, not via the clock aliases in clock*_data.c.

That will be doable only when main_clk will not be mapped to modulemode=
=2E=20
You cannot change the clock rate of the modulemode since it is a fake=20
clock :-(

>> How about OMAP3? It also has an optional functional clock, but that
>> doesn't seem to be set in dss_opt_clocks in omap_hwmod_3xxx_data.c.
>> Should it be there?
>
> Probably so.
>
>> It seems dss1_alwon_fclk is currently the main clock for OMAP3 dss
>> hwmods. Does that mean it can never be turned off if DSS is in use?
>
> If the DSS driver were using PM runtime, then yes, that would be true=
=2E

And then even if we switch to dss2 as the functional clock, dss1 cannot=
=20
be gated.

>> Ok. Then we need omap_hwmod_opt_clk for at least for VENC and HDMI, =
I
>> believe.
>
> In terms of the VENC, I'd agree with that -- based on OMAP4 Public TR=
M Rev
> O Figure 10-177 "Video Encoder Overview," it looks like VENC uses
> DSS_TV_FCLK.

If we do have an hwmod for dss_venc, we might consider the tv_clk as th=
e=20
main clock, which is the case anyway. The only tricky part is the=20
dependency with the dss modulemode / fclk that have to be enabled first=
=2E

> In terms of the HDMI IP block, based on OMAP4 Public TRM Rev O Figure
> 10-159 "HDMI Overview," it looks like sys_clk should be one of the
> optional clocks for HDMI?  Hard to tell from that diagram.
>
>>>> - Should every DSS module have their own PM runtime handling? (act=
ually
>>>> related to the question above)
>>>
>>> Yes, I think so.  From the integration perspective, we are trying t=
o get
>>> to the point where each omap_device maps to only one hwmod.
>>>
>>>> - If the modules are handled separately, how should the dependenci=
es be
>>>> handled? For example, dss_core's reset will reset all the other mo=
dules
>>>> also, and most of the submodules need functions from dss_core and
>>>> dss_dispc. So should, say, dss_dsi then call functions in core and=
 dispc
>>>> to "get" them, i.e. increase their pm runtime use count?
>>>
>>> Probably not.
>>>
>>> Here is how I would suggest structuring the code.  This is only a n=
a=C3=AFve
>>> suggestion; you and your team almost certainly know better than I.
>>>
>>> I'd suggest that you separate low-level register access into .c fil=
es
>>> that are targeted specifically for the IP block.  So in the DSS cas=
e,
>>> you'd have dss.c, dispc.c, dsi.c, hdmi.c, rfbi.c, venc.c.  Each one=
 should
>>> be a separate platform_device and would export symbols.  Hopefully,=
 there
>>> should be no cross-dependencies between these low-level files.
>>>
>>> Then you'd have "higher-level" code that might need to read/write f=
rom
>>> multiple DSS submodules to complete some higher-level operation.  T=
hat
>>> would be at least one separate driver -- say, "dss2" or something -=
- with
>>> dependencies on the low-level drivers.  So, for example, when that
>>> higher-level driver is modprobe'd, Linux would also load the driver=
s for
>>> the underlying hardware blocks that it uses.
>>
>> But this still leaves my question open: If this "dss2" needs to use,
>> say, dispc.c and dsi.c, those low level drivers need to be enabled. =
So I
>> guess we would have something like dispc_get() or dispc_enable(), wh=
ich
>> dss2 would call first. Those functions would then use pm_runtime to
>> enable the HW module. And the higher level driver would keep the low
>> level devices enabled while its doing something.
>
> That makes sense to me.
>
>> I have been thinking something like this also earlier. It would sepa=
rate
>> things cleanly. One thing I don't like about it is the big amount of=
 low
>> level DSS internal functions that need to be exported.
>
> Yeah, that's one of the downsides of that approach.
>
>>>> - There seems to be some child/parent relationships in PM runtime.
>>>> Should dss_core be the parent for the rest of the DSS modules? Thi=
s
>>>> would at least solve the reset issue easily, I guess.
>>>
>>> Yes, I think that's more accurate, anyway.  Something isn't right w=
ith the
>>
>> How are the child/parent relationships done for omap_devices? Does i=
t
>> come somehow from the hwmod data?
>
> Right now, there's no explicit support in omap_device for parent/chil=
d
> relationships.  Probably the right place for that is in the omap_hwmo=
d
> layer, since omap_device code just maps the hwmod data into the Linux
> device/driver model.  There is an interconnect hierarchy that's encod=
ed in
> the omap_hwmod data, but currently there's no explicit handling for a=
 case
> where a parent hwmod needs to be enabled for a child device to be
> accessed.  So far we haven't encountered any use-cases that require t=
his,
> but I've suspected that this needs to be added to the hwmod code, and=
 DSS
> may be the case that justifies it.

Do we really have to add that in hwmod core code? Cannot we let the=20
driver stack handle that dependency? Assuming we have a device for the=20
low level DSS code and assuming it is doing more than just enabling /=20
disabling the module.

Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
