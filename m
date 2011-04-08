From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Fri, 8 Apr 2011 10:28:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>  <1301900022.2715.12.camel@deskari>
  <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com> <1302241893.2102.21.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1315980156-1302280112=:22291"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50203 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1DHQ2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Apr 2011 12:28:33 -0400
In-Reply-To: <1302241893.2102.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1315980156-1302280112=:22291
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tomi,

On Fri, 8 Apr 2011, Tomi Valkeinen wrote:

> > Also, I hope you and the other DSS hackers can finish the PM runtime
> > conversion of the DSS driver soon.  Ideally before any new DSS
> > features are added.  We really need to be able to separate the OMAP
> > integration details from the drivers, and right now, hwmod and PM
> > runtime are the best way we have to do that.
>=20
> I also started to look at the PM runtime, but it doesn't fix the issue
> with the inconsistent clock name I described above.

After the hwmod/PM runtime conversion, I don't think any of the clock=20
aliases currently in clock*_data.c should be used by the DSS driver (or by=
=20
anything else on the system, for that matter).  That's because the=20
omap_device code should set up the "main" alias for the DSS main=20
functional clock[*], as well as the aliases in the optional clock data in=
=20
the OMAP hwmod data files:

static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
=09{ .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
=09{ .role =3D "tv_clk", .clk =3D "dss_tv_clk" },
=09{ .role =3D "dss_clk", .clk =3D "dss_dss_clk" },
=09{ .role =3D "video_clk", .clk =3D "dss_48mhz_clk" },
};

It might be that some of these role names aren't quite accurate and need=20
to be changed.  Those are intended to be meaningful to the driver, so=20
comments there are definitely welcome.

[*]. The "main" alias should be defined by the omap_device code=20
automatically, similarly to how _add_optional_clock_clkdev() does it.  It=
=20
does not do so currently.  This needs to be fixed in the omap_device.c=20
code.

> I also have some questions regarding PM runtime, perhaps I'll just put
> them here as they are slightly related:
>=20
> - Should every DSS module handle their clocks independently, i.e. should
> VENC get its own clocks and DSI should get its own? If so, we need a
> bunch of new clock aliases so the devices can get their clocks.

If all that driver code needs to do is to enable its main functional clock=
=20
when it is active and disable that clock when the driver is inactive,=20
then, no, the drivers shouldn't need their own clock aliases.  Same if the=
=20
driver only needs to get the rate or set the rate on that main functional=
=20
clock, since that alias should be set up automatically.

But if the driver for that submodule needs to control PRCM-provided=20
optional clocks, then it will need to have struct omap_hwmod_opt_clk=20
entries defined in the hwmod data.

> - Should every DSS module have their own PM runtime handling? (actually
> related to the question above)

Yes, I think so.  From the integration perspective, we are trying to get=20
to the point where each omap_device maps to only one hwmod.

> - If the modules are handled separately, how should the dependencies be=
=20
> handled? For example, dss_core's reset will reset all the other modules=
=20
> also, and most of the submodules need functions from dss_core and=20
> dss_dispc. So should, say, dss_dsi then call functions in core and dispc=
=20
> to "get" them, i.e. increase their pm runtime use count?

Probably not.

Here is how I would suggest structuring the code.  This is only a na=C3=AFv=
e=20
suggestion; you and your team almost certainly know better than I.

I'd suggest that you separate low-level register access into .c files=20
that are targeted specifically for the IP block.  So in the DSS case,=20
you'd have dss.c, dispc.c, dsi.c, hdmi.c, rfbi.c, venc.c.  Each one should=
=20
be a separate platform_device and would export symbols.  Hopefully, there=
=20
should be no cross-dependencies between these low-level files.

Then you'd have "higher-level" code that might need to read/write from=20
multiple DSS submodules to complete some higher-level operation.  That=20
would be at least one separate driver -- say, "dss2" or something -- with=
=20
dependencies on the low-level drivers.  So, for example, when that=20
higher-level driver is modprobe'd, Linux would also load the drivers for=20
the underlying hardware blocks that it uses.

> - There seems to be some child/parent relationships in PM runtime.
> Should dss_core be the parent for the rest of the DSS modules? This
> would at least solve the reset issue easily, I guess.

Yes, I think that's more accurate, anyway.  Something isn't right with the=
=20
DSS hwmod data.  According to the OMAP4 Public TRM Rev O Table 10-3 "DSS=20
Integration," there's a Sonics LX bus lurking in there.  All of the DSS=20
submodules should have slave sockets with that Sonics LX bus as their=20
master.  And the hwmod associated with the SLX should have an address=20
range that covers all of the DSS submodules.  I assume that the logical=20
hwmod to associate the SLX with is "dss_core", as you write.

Also, I notice the "CAUTION" boxes in Section 10.1.3 "DSS Register=20
Manual", 10.2.7 "Display Controller Register Manual", etc. etc., that say=
=20
that the DSS and submodules should be accessed through the L3 address=20
space.  But all of the DSS hwmod register targets are listed as the L4_PER=
=20
variants.  So the hwmod data also doesn't appear to be correct there.  The=
=20
correct approach would be to have both address spaces listed in struct=20
omap_hwmod_addr_space arrays, but to mark only the struct=20
omap_hwmod_ocp_if entry associated with the L3 bus as OCP_USER_MPU |=20
OCP_USER_SDMA[*].

[*]. On the OMAP core code, looks like we'll also want to modify=20
omap_hwmod_build_resources() to mark resources with IORESOURCE_DISABLED if=
=20
they are not marked with any OCP_USER_* flags, and patch the functions in=
=20
drivers/base/platform.c to skip any resources with IORESOURCE_DISABLED=20
set.

> - How does saving/restoring the registers for OFF mode go with PM
> runtime? Should the registers be saved in runtime_suspend(), and
> restored in runtime_resume()?

If you don't use shadow registers, then I think so, yes, although Kevin=20
might know better than I.

> Can/should omap_pm_get_dev_context_loss_count() still be used to=20
> optimize the restoring?

Yes.

=2E..

I regret that this process is relatively complicated :-(  As you and/or=20
your team works on this, changes to the hwmod/omap_device/clock core will=
=20
almost certainly be needed.  Please don't hesitate to let us know what's=20
not working for you, or to try out patches to the core infrastructure to=20
fix what you need.  If I don't respond, please just keep pinging.  I=20
wasn't able to fully analyze the DSS module when we originally wrote the=20
hwmod code, so surely we'll need to fix some bugs or make some changes for=
=20
things to make sense.

best regards,


- Paul
--155748971-1315980156-1302280112=:22291--
