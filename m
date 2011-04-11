From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 10:05:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104110946000.22291@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>  <1301900022.2715.12.camel@deskari>
  <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>  <1302241893.2102.21.camel@deskari>  <alpine.DEB.2.00.1104080903490.22291@utopia.booyaka.com> <1302512187.2198.44.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-20826086-1302537933=:22291"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38464 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1DKQFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 12:05:34 -0400
In-Reply-To: <1302512187.2198.44.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-20826086-1302537933=:22291
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Mon, 11 Apr 2011, Tomi Valkeinen wrote:

> On Fri, 2011-04-08 at 10:28 -0600, Paul Walmsley wrote:
> > On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
> >=20
> > > > Also, I hope you and the other DSS hackers can finish the PM runtim=
e
> > > > conversion of the DSS driver soon.  Ideally before any new DSS
> > > > features are added.  We really need to be able to separate the OMAP
> > > > integration details from the drivers, and right now, hwmod and PM
> > > > runtime are the best way we have to do that.
> > >=20
> > > I also started to look at the PM runtime, but it doesn't fix the issu=
e
> > > with the inconsistent clock name I described above.
> >=20
> > After the hwmod/PM runtime conversion, I don't think any of the clock=
=20
> > aliases currently in clock*_data.c should be used by the DSS driver (or=
 by=20
> > anything else on the system, for that matter).  That's because the=20
> > omap_device code should set up the "main" alias for the DSS main=20
>=20
> When should "main" clock be used by the driver? Or never, and pm_runtime
> handles that?

If the DSS needs to change the parent or the clock rate of the main clock,=
=20
then it will need to clk_get(dev, "main") and use the clock API.  My only=
=20
point here was that the "main" alias should be automatically added by the=
=20
omap_device code, not via the clock aliases in clock*_data.c.

> How about OMAP3? It also has an optional functional clock, but that
> doesn't seem to be set in dss_opt_clocks in omap_hwmod_3xxx_data.c.
> Should it be there?

Probably so.

> It seems dss1_alwon_fclk is currently the main clock for OMAP3 dss
> hwmods. Does that mean it can never be turned off if DSS is in use?

If the DSS driver were using PM runtime, then yes, that would be true.

> Ok. Then we need omap_hwmod_opt_clk for at least for VENC and HDMI, I
> believe.

In terms of the VENC, I'd agree with that -- based on OMAP4 Public TRM Rev=
=20
O Figure 10-177 "Video Encoder Overview," it looks like VENC uses=20
DSS_TV_FCLK.

In terms of the HDMI IP block, based on OMAP4 Public TRM Rev O Figure=20
10-159 "HDMI Overview," it looks like sys_clk should be one of the=20
optional clocks for HDMI?  Hard to tell from that diagram.

> > > - Should every DSS module have their own PM runtime handling? (actual=
ly
> > > related to the question above)
> >=20
> > Yes, I think so.  From the integration perspective, we are trying to ge=
t=20
> > to the point where each omap_device maps to only one hwmod.
> >=20
> > > - If the modules are handled separately, how should the dependencies =
be=20
> > > handled? For example, dss_core's reset will reset all the other modul=
es=20
> > > also, and most of the submodules need functions from dss_core and=20
> > > dss_dispc. So should, say, dss_dsi then call functions in core and di=
spc=20
> > > to "get" them, i.e. increase their pm runtime use count?
> >=20
> > Probably not.
> >=20
> > Here is how I would suggest structuring the code.  This is only a na=C3=
=AFve=20
> > suggestion; you and your team almost certainly know better than I.
> >=20
> > I'd suggest that you separate low-level register access into .c files=
=20
> > that are targeted specifically for the IP block.  So in the DSS case,=
=20
> > you'd have dss.c, dispc.c, dsi.c, hdmi.c, rfbi.c, venc.c.  Each one sho=
uld=20
> > be a separate platform_device and would export symbols.  Hopefully, the=
re=20
> > should be no cross-dependencies between these low-level files.
> >=20
> > Then you'd have "higher-level" code that might need to read/write from=
=20
> > multiple DSS submodules to complete some higher-level operation.  That=
=20
> > would be at least one separate driver -- say, "dss2" or something -- wi=
th=20
> > dependencies on the low-level drivers.  So, for example, when that=20
> > higher-level driver is modprobe'd, Linux would also load the drivers fo=
r=20
> > the underlying hardware blocks that it uses.
>=20
> But this still leaves my question open: If this "dss2" needs to use,
> say, dispc.c and dsi.c, those low level drivers need to be enabled. So I
> guess we would have something like dispc_get() or dispc_enable(), which
> dss2 would call first. Those functions would then use pm_runtime to
> enable the HW module. And the higher level driver would keep the low
> level devices enabled while its doing something.

That makes sense to me.

> I have been thinking something like this also earlier. It would separate
> things cleanly. One thing I don't like about it is the big amount of low
> level DSS internal functions that need to be exported.

Yeah, that's one of the downsides of that approach.

> > > - There seems to be some child/parent relationships in PM runtime.
> > > Should dss_core be the parent for the rest of the DSS modules? This
> > > would at least solve the reset issue easily, I guess.
> >=20
> > Yes, I think that's more accurate, anyway.  Something isn't right with =
the=20
>=20
> How are the child/parent relationships done for omap_devices? Does it
> come somehow from the hwmod data?=20

Right now, there's no explicit support in omap_device for parent/child=20
relationships.  Probably the right place for that is in the omap_hwmod=20
layer, since omap_device code just maps the hwmod data into the Linux=20
device/driver model.  There is an interconnect hierarchy that's encoded in=
=20
the omap_hwmod data, but currently there's no explicit handling for a case=
=20
where a parent hwmod needs to be enabled for a child device to be=20
accessed.  So far we haven't encountered any use-cases that require this,=
=20
but I've suspected that this needs to be added to the hwmod code, and DSS=
=20
may be the case that justifies it.

> > DSS hwmod data.  According to the OMAP4 Public TRM Rev O Table 10-3 "DS=
S=20
> > Integration," there's a Sonics LX bus lurking in there.  All of the DSS=
=20
> > submodules should have slave sockets with that Sonics LX bus as their=
=20
> > master.  And the hwmod associated with the SLX should have an address=
=20
> > range that covers all of the DSS submodules.  I assume that the logical=
=20
> > hwmod to associate the SLX with is "dss_core", as you write.
> >=20
> > Also, I notice the "CAUTION" boxes in Section 10.1.3 "DSS Register=20
> > Manual", 10.2.7 "Display Controller Register Manual", etc. etc., that s=
ay=20
> > that the DSS and submodules should be accessed through the L3 address=
=20
> > space.  But all of the DSS hwmod register targets are listed as the L4_=
PER=20
> > variants.  So the hwmod data also doesn't appear to be correct there.  =
The=20
> > correct approach would be to have both address spaces listed in struct=
=20
> > omap_hwmod_addr_space arrays, but to mark only the struct=20
> > omap_hwmod_ocp_if entry associated with the L3 bus as OCP_USER_MPU |=20
> > OCP_USER_SDMA[*].
>=20
> As far as I'm concerned, L4 interface can be removed totally. TRM says
> "The access through the L4_PER interconnect is provided for back
> software compatibility.".

Okay, good to know.  We may leave them in there - the goal of the hwmod=20
data is to describe the hardware independently of the Linux drivers.  But=
=20
either way, the other set of addresses shouldn't appear to the DSS driver,=
=20
so it's really a core code issue.


regards,

- Paul
--155748971-20826086-1302537933=:22291--
