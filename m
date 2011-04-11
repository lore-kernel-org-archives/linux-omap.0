From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 11:56:27 +0300
Message-ID: <1302512187.2198.44.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
	 <1302241893.2102.21.camel@deskari>
	 <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55818 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757643Ab1DKI4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 04:56:35 -0400
Received: by fxm3 with SMTP id 3so3862589fxm.30
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 01:56:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2011-04-08 at 10:28 -0600, Paul Walmsley wrote:
> Hi Tomi,
>=20
> On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
>=20
> > > Also, I hope you and the other DSS hackers can finish the PM runt=
ime
> > > conversion of the DSS driver soon.  Ideally before any new DSS
> > > features are added.  We really need to be able to separate the OM=
AP
> > > integration details from the drivers, and right now, hwmod and PM
> > > runtime are the best way we have to do that.
> >=20
> > I also started to look at the PM runtime, but it doesn't fix the is=
sue
> > with the inconsistent clock name I described above.
>=20
> After the hwmod/PM runtime conversion, I don't think any of the clock=
=20
> aliases currently in clock*_data.c should be used by the DSS driver (=
or by=20
> anything else on the system, for that matter).  That's because the=20
> omap_device code should set up the "main" alias for the DSS main=20

When should "main" clock be used by the driver? Or never, and pm_runtim=
e
handles that?

> functional clock[*], as well as the aliases in the optional clock dat=
a in=20
> the OMAP hwmod data files:
>=20
> static struct omap_hwmod_opt_clk dss_opt_clks[] =3D {
> 	{ .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
> 	{ .role =3D "tv_clk", .clk =3D "dss_tv_clk" },
> 	{ .role =3D "dss_clk", .clk =3D "dss_dss_clk" },
> 	{ .role =3D "video_clk", .clk =3D "dss_48mhz_clk" },
> };
>=20
> It might be that some of these role names aren't quite accurate and n=
eed=20
> to be changed.  Those are intended to be meaningful to the driver, so=
=20
> comments there are definitely welcome.

How about OMAP3? It also has an optional functional clock, but that
doesn't seem to be set in dss_opt_clocks in omap_hwmod_3xxx_data.c.
Should it be there?

It seems dss1_alwon_fclk is currently the main clock for OMAP3 dss
hwmods. Does that mean it can never be turned off if DSS is in use?

> [*]. The "main" alias should be defined by the omap_device code=20
> automatically, similarly to how _add_optional_clock_clkdev() does it.=
  It=20
> does not do so currently.  This needs to be fixed in the omap_device.=
c=20
> code.
>=20
> > I also have some questions regarding PM runtime, perhaps I'll just =
put
> > them here as they are slightly related:
> >=20
> > - Should every DSS module handle their clocks independently, i.e. s=
hould
> > VENC get its own clocks and DSI should get its own? If so, we need =
a
> > bunch of new clock aliases so the devices can get their clocks.
>=20
> If all that driver code needs to do is to enable its main functional =
clock=20
> when it is active and disable that clock when the driver is inactive,=
=20
> then, no, the drivers shouldn't need their own clock aliases.  Same i=
f the=20
> driver only needs to get the rate or set the rate on that main functi=
onal=20
> clock, since that alias should be set up automatically.
>=20
> But if the driver for that submodule needs to control PRCM-provided=20
> optional clocks, then it will need to have struct omap_hwmod_opt_clk=20
> entries defined in the hwmod data.

Ok. Then we need omap_hwmod_opt_clk for at least for VENC and HDMI, I
believe.

> > - Should every DSS module have their own PM runtime handling? (actu=
ally
> > related to the question above)
>=20
> Yes, I think so.  From the integration perspective, we are trying to =
get=20
> to the point where each omap_device maps to only one hwmod.
>=20
> > - If the modules are handled separately, how should the dependencie=
s be=20
> > handled? For example, dss_core's reset will reset all the other mod=
ules=20
> > also, and most of the submodules need functions from dss_core and=20
> > dss_dispc. So should, say, dss_dsi then call functions in core and =
dispc=20
> > to "get" them, i.e. increase their pm runtime use count?
>=20
> Probably not.
>=20
> Here is how I would suggest structuring the code.  This is only a na=C3=
=AFve=20
> suggestion; you and your team almost certainly know better than I.
>=20
> I'd suggest that you separate low-level register access into .c files=
=20
> that are targeted specifically for the IP block.  So in the DSS case,=
=20
> you'd have dss.c, dispc.c, dsi.c, hdmi.c, rfbi.c, venc.c.  Each one s=
hould=20
> be a separate platform_device and would export symbols.  Hopefully, t=
here=20
> should be no cross-dependencies between these low-level files.
>=20
> Then you'd have "higher-level" code that might need to read/write fro=
m=20
> multiple DSS submodules to complete some higher-level operation.  Tha=
t=20
> would be at least one separate driver -- say, "dss2" or something -- =
with=20
> dependencies on the low-level drivers.  So, for example, when that=20
> higher-level driver is modprobe'd, Linux would also load the drivers =
for=20
> the underlying hardware blocks that it uses.

But this still leaves my question open: If this "dss2" needs to use,
say, dispc.c and dsi.c, those low level drivers need to be enabled. So =
I
guess we would have something like dispc_get() or dispc_enable(), which
dss2 would call first. Those functions would then use pm_runtime to
enable the HW module. And the higher level driver would keep the low
level devices enabled while its doing something.

I have been thinking something like this also earlier. It would separat=
e
things cleanly. One thing I don't like about it is the big amount of lo=
w
level DSS internal functions that need to be exported.

> > - There seems to be some child/parent relationships in PM runtime.
> > Should dss_core be the parent for the rest of the DSS modules? This
> > would at least solve the reset issue easily, I guess.
>=20
> Yes, I think that's more accurate, anyway.  Something isn't right wit=
h the=20

How are the child/parent relationships done for omap_devices? Does it
come somehow from the hwmod data?=20

> DSS hwmod data.  According to the OMAP4 Public TRM Rev O Table 10-3 "=
DSS=20
> Integration," there's a Sonics LX bus lurking in there.  All of the D=
SS=20
> submodules should have slave sockets with that Sonics LX bus as their=
=20
> master.  And the hwmod associated with the SLX should have an address=
=20
> range that covers all of the DSS submodules.  I assume that the logic=
al=20
> hwmod to associate the SLX with is "dss_core", as you write.
>=20
> Also, I notice the "CAUTION" boxes in Section 10.1.3 "DSS Register=20
> Manual", 10.2.7 "Display Controller Register Manual", etc. etc., that=
 say=20
> that the DSS and submodules should be accessed through the L3 address=
=20
> space.  But all of the DSS hwmod register targets are listed as the L=
4_PER=20
> variants.  So the hwmod data also doesn't appear to be correct there.=
  The=20
> correct approach would be to have both address spaces listed in struc=
t=20
> omap_hwmod_addr_space arrays, but to mark only the struct=20
> omap_hwmod_ocp_if entry associated with the L3 bus as OCP_USER_MPU |=20
> OCP_USER_SDMA[*].

As far as I'm concerned, L4 interface can be removed totally. TRM says
"The access through the L4_PER interconnect is provided for back
software compatibility.".

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
