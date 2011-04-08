From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 08 Apr 2011 08:51:33 +0300
Message-ID: <1302241893.2102.21.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54751 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383Ab1DHFvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 01:51:40 -0400
Received: by eye27 with SMTP id 27so1048097eye.20
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 22:51:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Paul,

On Thu, 2011-04-07 at 13:27 -0600, Paul Walmsley wrote:
> Hello Tomi, Beno=C3=AEt,
>=20
> On Mon, 4 Apr 2011, Tomi Valkeinen wrote:
>=20
> > On Fri, 2011-04-01 at 20:12 -0600, Paul Walmsley wrote:
> >=20
> > > Based on the E-mail thread so far, I'd say that changing the cloc=
k aliases=20
> > > is the way to go for right now.  The clock aliases are not hardwa=
re data;=20
> > > they just control how the clock hardware is mapped to the drivers=
=2E
> >=20
> > I'd very much prefer this option. Below is a patch for this.
> >=20
> > If Benoit doesn't complain too much about this, I'd like to get thi=
s
> > merged as soon as possible, as OMAP4 DSS is currently crashing in t=
he
> > mainline kernel.
>=20
> I will queue your clock aliases patch and attempt to merge it upstrea=
m for=20
> the -rc series.  I am not happy to be disagreeing with Beno=C3=AEt he=
re, but=20
> this is the rationale that I am using.  (Beno=C3=AEt, Tomi, please fe=
el free to=20
> correct if there is something blatantly false below.)
>=20
> 1. The integration of the DSS module is an unusual case.  The
>    MODULEMODE bits for the DSS bits do not control the DSS "main"
>    functional clock (the clock that is needed to access device
>    registers); instead, they only control the DSS interface clock.
>    (This is because the DSS can use a functional clock that is not
>    provided by the OMAP core.)  So calling the DSS MODULEMODE struct
>    clk "dss_fck" is not really correct, since it is really controllin=
g
>    the interface clock.

If we don't apply the patch, I think the clock aliases are still broken=
=2E
Let's forget the ick/fck thing for a second, and just think the clock
from PRCM which is used as the source clock for pixel clock. That is
currently called "fck" on OMAP2/3, but "dss_dss_clk" on OMAP4. This
cannot be right, can it? From DSS's point of view that is the same
clock, it should clearly have the same alias on all platforms. I don't
care what the name is as long as it's consistent on all platforms.

And I have to say I still don't quite get it what is the problem with
"fck" name. Or is that meant to be a clock which enables the registers
on the module, and not the clock used for the pixel clock? If so, I'm
fine with having "fck" to be what it is currently, but then we need a
new name for the clock used for pixel clock, which is consistent on all
platforms.

> 2. This patch does not create a precedent for hacking around general
>    driver clocking problems in the clock or clock data.  This is only
>    needed because the MODULEMODE bits don't control the module
>    functional clock in this case.  As I understand it, the only other
>    device that this problem could occur with is McBSP, due to
>    mcbsp_clks.
>=20
> 3. The existing DSS2 driver clock design apparently works fine when
>    this change is implemented[1], so no driver changes will be needed=
=2E
>=20
> 4. The proposed DSS driver patch to work around this uses a nasty hac=
k
>    that really should be NACK'ed[2].
>=20
> All this said, we may not be able to merge this change upstream, due =
to=20
> the recent unhappiness about the clock data changes.  If Linus reject=
s it,=20
> you'll need a "Plan B."
>=20
> ...
>=20
> Also, I hope you and the other DSS hackers can finish the PM runtime
> conversion of the DSS driver soon.  Ideally before any new DSS
> features are added.  We really need to be able to separate the OMAP
> integration details from the drivers, and right now, hwmod and PM
> runtime are the best way we have to do that.

I also started to look at the PM runtime, but it doesn't fix the issue
with the inconsistent clock name I described above.

I also have some questions regarding PM runtime, perhaps I'll just put
them here as they are slightly related:

- Should every DSS module handle their clocks independently, i.e. shoul=
d
VENC get its own clocks and DSI should get its own? If so, we need a
bunch of new clock aliases so the devices can get their clocks.

- Should every DSS module have their own PM runtime handling? (actually
related to the question above)

- If the modules are handled separately, how should the dependencies be
handled? For example, dss_core's reset will reset all the other modules
also, and most of the submodules need functions from dss_core and
dss_dispc. So should, say, dss_dsi then call functions in core and disp=
c
to "get" them, i.e. increase their pm runtime use count?

- There seems to be some child/parent relationships in PM runtime.
Should dss_core be the parent for the rest of the DSS modules? This
would at least solve the reset issue easily, I guess.

- How does saving/restoring the registers for OFF mode go with PM
runtime? Should the registers be saved in runtime_suspend(), and
restored in runtime_resume()? Can/should
omap_pm_get_dev_context_loss_count() still be used to optimize the
restoring?

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
