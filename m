From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Wed, 24 Nov 2010 18:31:00 +0200
Message-ID: <20101124163100.GB5681@nokia.com>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
 <1290589057.13243.22.camel@tubuntu>
 <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17073 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab0KXQbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 11:31:23 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Nov 24, 2010 at 03:39:44PM +0530, ext Hiremath, Vaibhav wrote:
>=20
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Wednesday, November 24, 2010 2:28 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
> >=20
> > On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
> > > Hi,
> > >
> > > While supporting one of customer I came across one interesting is=
sue and
> > finding with WAITFORVSYNC ioctl -
> > >
> > > Problem Statement -
> > > -------------------
> > > With WAITFORVSYNC lots of tearing artifacts are visible on LCD ou=
tput,
> > but WAITFORGO works fine without any issues.
> > >
> > > Debugging/Findings -
> > > --------------------
> > >
> > > Technically both, WAITFORVSYNC and WAITFORGO wait on VSYNC interr=
upt -
> > but there is slight difference in their implementation/processing.
> >=20
> > No, that's not quite right.
> >=20
> > WAITFORVSYNC waits for the next vsync.
> >=20
> [Hiremath, Vaibhav] Yes, certainly.
>=20
> > WAITFORGO waits until the the config changes for the particular ove=
rlay
> > have been applied to the HW, which may take multiple vsyncs if ther=
e are
> > already pending config changes. Or, if there are no changes to be
> > applied, it doesn't wait at all.
> >=20
> [Hiremath, Vaibhav] Yes, completely agreed. But in the panning use-ca=
se where if we assume there will be always config change when you enter=
 WAIFORGO ioctl it waits for next VSYNC, and as you mentioned it may wa=
it for multiple vsyncs to make sure that config change gets applied to =
HW.
>=20
> > > WAITFORGO ioctl ensures that dirty & shadow_dirty flags (software=
 flag)
> > are cleared, making sure that hardware state and software state alw=
ays
> > stays in sync. It makes 4 attempts to do so - inside loop it checks=
 for
> > dirty flags and call wait_for_vsync API. In ideal usecase scenario =
it
> > should come out in single iteration.
> <snip>
>=20
> > > Suggestions/Recommendation -
> > > --------------------------
> > >
> > > From User application point of view, user won't care about driver
> > internal implementation. Application believes that WAITFORVSYNC wil=
l only
> > return after displaying (DMAing) previous buffer and now with addit=
ion to
> > FBIO_WAITFORVSYNC standard ioctl interface this is very well expect=
ed from
> > user application as a standard behavior.
> > >
> > > I would recommend having WAITFORGO like implementation under
> > WAITFORVSYNC, merging WAITFORGO with WAITFORVSYNC, and killing WAIT=
=46ORGO
> > (since we have FBIO_WAITFORVSYNC standard ioctl).
> > > Also WAITFORGO ioctl is OMAP specific custom ioctl.
> >=20
> > I have to say that I'm not quite sure what WAITFORVSYNC should do.=20
> [Hiremath, Vaibhav] Me neither.
>=20
> > The
> > name implies that it should wait for the next vsync, which is what =
it
> > does for omapfb.
> >=20
>=20
> > Changing it to WAITFORGO would alter the behaviour. Sometimes it wo=
uld
> > not wait at all, sometimes it could wait for multiple vsyncs.
> [Hiremath, Vaibhav] I am quite not sure, whether it makes sense from =
application point of view to wait for vsync if config is not changed. W=
hat could be the use-case for such requirement, where application won't=
 change anything but still would like to wait on vsync?
>=20
> And as far as wait on multiple vsync is concerned, it does make sense=
 to coat "WAITFORVSYNC ioctl makes sure that your change got applied to=
 HW".=20
>=20
> I am not aware of other architectures, but I believe this is somethin=
g OMAP specific stuff. And for other platforms, WAITFORVSYNC means chan=
ges applied to HW (why does apps care about whether it is vsync or anyt=
hing else?).

WAITFORVSYNC waits for the next vsync (or actually vblank in many
cases). That's it. I don't see any point in trying to shoehorn
other functionality into it.

If you want to standardise WAITFORGO type of stuff then just add
another standard ioctl for it.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
