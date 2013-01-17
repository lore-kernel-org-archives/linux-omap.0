From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Thu, 17 Jan 2013 22:01:43 +1100
Message-ID: <20130117220143.1cdf362e@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50F67A50.5020203@ti.com>
	<20130116212715.2567d5ed@notabene.brown>
	<50F68784.8050708@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/js.FLckkws2k5pZJwPo70N2"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42622 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335Ab3AQLBz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jan 2013 06:01:55 -0500
In-Reply-To: <50F68784.8050708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/js.FLckkws2k5pZJwPo70N2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jan 2013 12:57:08 +0200 Roger Quadros <rogerq@ti.com> wrote:

> On 01/16/2013 12:27 PM, NeilBrown wrote:
> > On Wed, 16 Jan 2013 12:00:48 +0200 Roger Quadros <rogerq@ti.com> wrote:
> >=20
> >> On 01/09/2013 12:29 AM, NeilBrown wrote:
> >>>
> >>> Hi,
> >>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
> >>>
> >>> My current stumbling block is USB.  The "Option" GSM module is attach=
ed via
> >>> USB (there is a separate transceiver chip attached to port 1 which is=
 placed
> >>> in OMAP_EHCI_PORT_MODE_PHY).
> >>>
> >>> After a suspend/resume cycle with off_mode enabled the GSM module dis=
appears.
> >>> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices =
don't
> >>> exist.
> >>> Without off mode, the modem always appears after resume.
> >>>
> >>> I discovered that the registers set by:
> >>>
> >>>    drivers/mfd/omap-usb-host.c
> >>>
> >>> are not maintained across as suspend/resume so I added the following =
patch
> >>> (which I can make a formal submission of if it looks right to others)=
, but
> >>> that didn't help (or didn't help enough).
> >>>
> >>> If I
> >>>
> >>>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
> >>>
> >>> thus keeping just the USBHOST power domain out of off_mode, the GSM m=
odule
> >>> doesn't disappear.  So it seems that some context in the usbhost doma=
in is
> >>> not being save and restored.
> >>>
> >>> This is as far as I can get.  Can someone suggest where I should look=
 to find
> >>> out what is not being saved/restored properly, and how to go about sa=
ving and
> >>> restoring?
> >>
> >> You need to ensure that USBHOST/TLL context is saved as per the Save a=
nd
> >> Restore sequence see section "USBHOST/USBTLL Save-and-Restore
> >> Management" in the OMAP Technical Reference Manual.
> >>
> >> The basic idea there is that software does the context saving into SAR
> >> RAM before entering OFF mode and hardware automatically restores the
> >> context after coming out of OFF mode.
> >=20
> > Is it?  The way I read the doco, the hardware both saves to SAR RAM, and
> > restores from  SAR RAM.
> >   Section 22.2.4.1.6  Save and Restore
> > of my copy of the TRM says:
> >=20
> >> The save-and-restore (SAR) mechanism can extract the hardware context =
of the high-speed USB host
> >> controller (after all USB activity has been suspended) before switchin=
g off (=3Dsave), save it to an external
> >> always-on memory, and reinject it later after the module has been swit=
ched on again and reset (=3Drestore)
> >> seamlessly for the USB. Part of that context is composed of the regist=
er fields described in the current
> >> chapter. The rest of the context is composed of the "buried" flip-flop=
s and memories (not accessible by
> >> software) like finite state-machine (FSM) states, buffer contents, and=
 miscellaneous random logic bits.
> >=20
> > which strongly suggests that it is all handled by hardware.  Of course =
there
> > are other registers that aren't covered  by the SAR - we need to identi=
fy
> > those and make sure they are saved and restored.  I've found a few regi=
sters
> > that aren't being restored, but restoring them hasn't made a visible
> > difference yet.
>=20
> Yes, you are right. I mixed it up with OMAP4 behaviour, sorry.
> But still, software needs to ensure that the USBHOST and CORE power
> domain's SAVEANDRESTORE bit are set to ensure that SAR works.
>=20
> see section "3.5.4.6 USBHOST/USBTLL Save-and-Restore Management"
>=20
> This seems to be done by the powerdomain code based on the
> PWRDM_HAS_HDWR_SAR flag. However, this flag is disabled for USBHOST
> powerdomain with the following comment.
>=20
> > Both USBHOST and USBTLL support a save-and-restore mechanism. When the =
device enters into off
> > mode (that is, all power domains, except the WKUP power domain, are off=
), the user may want to save
> > the USBHOST context and restore it when exiting off mode. The save-and-=
restore mechanism for the HS
> > USB Host is enabled by setting the PRCM.PM_PWSTCTRL_USBHOST[4] SAVEANDR=
ESTORE bit; for
> > the USBTLL, it is configured by the PRCM.PM_PWSTCTRL_CORE[4] SAVEANDRES=
TORE bit. The save
> > mechanism is initiated as the power domain transitions from active to o=
ff state (or to OSWR state for the
> > USBTLL), whereas the restore mechanism is initiated as the power domain=
 transitions from off to active
> > power state.
>=20
> Can you try with the flag enabled?

If I keep CORE and  USBHOST out of off-mode (by writing to the relevant
'suspend' files in /sys/kernel/debug/pm-debug) then it all works.

If I set this flag, then I can allow USBHOST to enter off-mode as long as I
keep CORE in retention or better.

If I let CORE and USBHOST go to off-mode and don't have the flag set, then I
can resume from suspend, but the usb modem has disappeared.

If I let CORE and USBHOST go to off-mode and DO have the flag set, then I
cannot even resume from suspend.... sometimes.

I hate those "sometimes"s!

If I remove the battery (with no other power source present) and re-insert
it, and let the phone boot up to  stable state and then enter suspend, I
cannot resume from suspend.  (I tried setting "no_console_suspend" to see if
anything was happening - but that keeps CORE awake).

If I do the same but before  it suspends I:

   echo 1 > /sys/kernel/debug/pm_debug/core_pwrdm/suspend
  =20
then let is suspend and resume, the resume works.  Then I:

   echo 0 > /sys/kernel/debug/pm_debug/core_pwrdm/suspend

to allow full sleep mode and now suspend, and again resume works.
And it continues to work.
And the USB modem remains visible - it doesn't disconnect at all.

So.... something very odd is happening somewhere.
Maybe the USBHOST powerdomain isn't really going to off-mode again after the
first time like the comment in powerdomains3xxx_data.c says:

	/*
	 * REVISIT: Enabling usb host save and restore mechanism seems to
	 * leave the usb host domain permanently in ACTIVE mode after
	 * changing the usb host power domain state from OFF to active once.
	 * Disabling for now.
	 */

However the  /sys/kernel/debug/pm_debug/count file shows the "OFF" count for
usbhost_pwrdm increments on each suspend, and that seems to be based on info
read out of the the OMAP3 itself....

All very odd.

Thanks,
NeilBrown

--Sig_/js.FLckkws2k5pZJwPo70N2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUPfaFznsnt1WYoG5AQL7Xw/8D1gIOntu6UYGuJ3qB5VBYXyLOa8DWjlu
ytpF8JamOJgk/98m4i4O9dpWLRCD+Kbk44KLvRTybZgaCStU+Y+vfY8x3Df5z89i
SpoZ7BWPpSCktifdddXAzCKH4ihJXwVFpaJ0wIhtV27kWoKABsRRFeOIbci2jPBU
KBGhfBp8AqkhnFAfDRZskek6auF0jleA95X1jUbKuZJUrVE8CBwlfD3jSM5AmjN2
RK0zJnCqlglt6FjsAC91zl+KoLqZY9F8jdiEWi5ozyjBYxEXJjPvzKSFji6dBZvu
cKTgcbZVIA+lrZtDRV7YnrrOEVGeCeYetreh6ClSNNRFwaGAserH+UPi2eR1ybdS
o5gYMRQ6BCR08JNiyEXSAqBfqAGaGsYUqKGVnZ0X2Ul0o9lPSgnk4cQrEw/zmnxn
Z8/LG+BnWt4F7SZj/UhDEK7iYNFd9gyUDJJhFNXA+KqyNBH3XQB06sPOv69L5d2V
qLOvs2Z4naHJFaKNIqG8AIqBZCfU2n5Wtcoc/5SsBj0iHaD6r67/D4E/bLhTzrxf
ffm3/TMq4qnXMaxjJEyIHUa2F6iGrP6bEzQwPNJzNfVAFZUQp9hwQBaMqyrPanNn
cpsmZpylaMYLoHCEATjY7tpyo/bXGAMVHAFpRv88hoHNUzxO7qouwQEk0rrl1IUG
2RJawKwpIx4=
=YSux
-----END PGP SIGNATURE-----

--Sig_/js.FLckkws2k5pZJwPo70N2--
