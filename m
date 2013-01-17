From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Fri, 18 Jan 2013 08:08:34 +1100
Message-ID: <20130118080834.1b70a332@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50F67A50.5020203@ti.com>
	<20130116212715.2567d5ed@notabene.brown>
	<50F68784.8050708@ti.com>
	<20130117220143.1cdf362e@notabene.brown>
	<50F7E083.7040105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/4hTXp8p7htz0zAtamWuQcyv"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38846 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817Ab3AQVIr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jan 2013 16:08:47 -0500
In-Reply-To: <50F7E083.7040105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/4hTXp8p7htz0zAtamWuQcyv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jan 2013 13:29:07 +0200 Roger Quadros <rogerq@ti.com> wrote:

> On 01/17/2013 01:01 PM, NeilBrown wrote:
> > On Wed, 16 Jan 2013 12:57:08 +0200 Roger Quadros <rogerq@ti.com> wrote:
> >=20
> >> On 01/16/2013 12:27 PM, NeilBrown wrote:
> >>> On Wed, 16 Jan 2013 12:00:48 +0200 Roger Quadros <rogerq@ti.com> wrot=
e:
> >>>
> >>>> On 01/09/2013 12:29 AM, NeilBrown wrote:
> >>>>>
> >>>>> Hi,
> >>>>>  I'm trying to get off_mode working reliably on my gta04 mobile pho=
ne.
> >>>>>
> >>>>> My current stumbling block is USB.  The "Option" GSM module is atta=
ched via
> >>>>> USB (there is a separate transceiver chip attached to port 1 which =
is placed
> >>>>> in OMAP_EHCI_PORT_MODE_PHY).
> >>>>>
> >>>>> After a suspend/resume cycle with off_mode enabled the GSM module d=
isappears.
> >>>>> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx device=
s don't
> >>>>> exist.
> >>>>> Without off mode, the modem always appears after resume.
> >>>>>
> >>>>> I discovered that the registers set by:
> >>>>>
> >>>>>    drivers/mfd/omap-usb-host.c
> >>>>>
> >>>>> are not maintained across as suspend/resume so I added the followin=
g patch
> >>>>> (which I can make a formal submission of if it looks right to other=
s), but
> >>>>> that didn't help (or didn't help enough).
> >>>>>
> >>>>> If I
> >>>>>
> >>>>>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
> >>>>>
> >>>>> thus keeping just the USBHOST power domain out of off_mode, the GSM=
 module
> >>>>> doesn't disappear.  So it seems that some context in the usbhost do=
main is
> >>>>> not being save and restored.
> >>>>>
> >>>>> This is as far as I can get.  Can someone suggest where I should lo=
ok to find
> >>>>> out what is not being saved/restored properly, and how to go about =
saving and
> >>>>> restoring?
> >>>>
> >>>> You need to ensure that USBHOST/TLL context is saved as per the Save=
 and
> >>>> Restore sequence see section "USBHOST/USBTLL Save-and-Restore
> >>>> Management" in the OMAP Technical Reference Manual.
> >>>>
> >>>> The basic idea there is that software does the context saving into S=
AR
> >>>> RAM before entering OFF mode and hardware automatically restores the
> >>>> context after coming out of OFF mode.
> >>>
> >>> Is it?  The way I read the doco, the hardware both saves to SAR RAM, =
and
> >>> restores from  SAR RAM.
> >>>   Section 22.2.4.1.6  Save and Restore
> >>> of my copy of the TRM says:
> >>>
> >>>> The save-and-restore (SAR) mechanism can extract the hardware contex=
t of the high-speed USB host
> >>>> controller (after all USB activity has been suspended) before switch=
ing off (=3Dsave), save it to an external
> >>>> always-on memory, and reinject it later after the module has been sw=
itched on again and reset (=3Drestore)
> >>>> seamlessly for the USB. Part of that context is composed of the regi=
ster fields described in the current
> >>>> chapter. The rest of the context is composed of the "buried" flip-fl=
ops and memories (not accessible by
> >>>> software) like finite state-machine (FSM) states, buffer contents, a=
nd miscellaneous random logic bits.
> >>>
> >>> which strongly suggests that it is all handled by hardware.  Of cours=
e there
> >>> are other registers that aren't covered  by the SAR - we need to iden=
tify
> >>> those and make sure they are saved and restored.  I've found a few re=
gisters
> >>> that aren't being restored, but restoring them hasn't made a visible
> >>> difference yet.
> >>
> >> Yes, you are right. I mixed it up with OMAP4 behaviour, sorry.
> >> But still, software needs to ensure that the USBHOST and CORE power
> >> domain's SAVEANDRESTORE bit are set to ensure that SAR works.
> >>
> >> see section "3.5.4.6 USBHOST/USBTLL Save-and-Restore Management"
> >>
> >> This seems to be done by the powerdomain code based on the
> >> PWRDM_HAS_HDWR_SAR flag. However, this flag is disabled for USBHOST
> >> powerdomain with the following comment.
> >>
> >>> Both USBHOST and USBTLL support a save-and-restore mechanism. When th=
e device enters into off
> >>> mode (that is, all power domains, except the WKUP power domain, are o=
ff), the user may want to save
> >>> the USBHOST context and restore it when exiting off mode. The save-an=
d-restore mechanism for the HS
> >>> USB Host is enabled by setting the PRCM.PM_PWSTCTRL_USBHOST[4] SAVEAN=
DRESTORE bit; for
> >>> the USBTLL, it is configured by the PRCM.PM_PWSTCTRL_CORE[4] SAVEANDR=
ESTORE bit. The save
> >>> mechanism is initiated as the power domain transitions from active to=
 off state (or to OSWR state for the
> >>> USBTLL), whereas the restore mechanism is initiated as the power doma=
in transitions from off to active
> >>> power state.
> >>
> >> Can you try with the flag enabled?
> >=20
> > If I keep CORE and  USBHOST out of off-mode (by writing to the relevant
> > 'suspend' files in /sys/kernel/debug/pm-debug) then it all works.
> >=20
> > If I set this flag, then I can allow USBHOST to enter off-mode as long =
as I
> > keep CORE in retention or better.
> >=20
> > If I let CORE and USBHOST go to off-mode and don't have the flag set, t=
hen I
> > can resume from suspend, but the usb modem has disappeared.
> >=20
> > If I let CORE and USBHOST go to off-mode and DO have the flag set, then=
 I
> > cannot even resume from suspend.... sometimes.
> >=20
>=20
> It looks like the problem creeps in when the OMAP device hits OFF. i.e.
> CORE is allowed to go OFF.
>=20
> > I hate those "sometimes"s!
> >=20
> > If I remove the battery (with no other power source present) and re-ins=
ert
> > it, and let the phone boot up to  stable state and then enter suspend, I
> > cannot resume from suspend.  (I tried setting "no_console_suspend" to s=
ee if
> > anything was happening - but that keeps CORE awake).
> >=20
> > If I do the same but before  it suspends I:
> >=20
> >    echo 1 > /sys/kernel/debug/pm_debug/core_pwrdm/suspend
> >   =20
> > then let is suspend and resume, the resume works.  Then I:
> >=20
> >    echo 0 > /sys/kernel/debug/pm_debug/core_pwrdm/suspend
> >=20
> > to allow full sleep mode and now suspend, and again resume works.
> > And it continues to work.
> > And the USB modem remains visible - it doesn't disconnect at all.
> >=20
>=20
> So does repeated suspend/resume work after this? Or is it only the first
> suspend/resume.

suspend/resume continues to work until a power-down.
Even after a soft reboot (which goes back to ILO and u-boot, but doesn't
remove power), suspend/resume continue to work.
It is only after a power-off that I need one suspend cycle with CORE in
retention before things work.

>=20
> > So.... something very odd is happening somewhere.
> > Maybe the USBHOST powerdomain isn't really going to off-mode again afte=
r the
> > first time like the comment in powerdomains3xxx_data.c says:
> >=20
> > 	/*
> > 	 * REVISIT: Enabling usb host save and restore mechanism seems to
> > 	 * leave the usb host domain permanently in ACTIVE mode after
> > 	 * changing the usb host power domain state from OFF to active once.
> > 	 * Disabling for now.
> > 	 */
> >=20
> > However the  /sys/kernel/debug/pm_debug/count file shows the "OFF" coun=
t for
> > usbhost_pwrdm increments on each suspend, and that seems to be based on=
 info
> > read out of the the OMAP3 itself....
> >=20
> > All very odd.
>=20
> I need to give this a try. I can try it out on OMAP3 beagle board.
>=20
> What OMAP3 are you on, and which kernel are you using for your tests?

I believe it is a DM3730

# cat /proc/cpuinfo=20
Processor	: ARMv7 Processor rev 2 (v7l)
BogoMIPS	: 311.92
Features	: swp half thumb fastmult vfp edsp thumbee neon vfpv3 tls=20
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x3
CPU part	: 0xc08
CPU revision	: 2

Hardware	: GTA04
Revision	: 0020
Serial		: 0000000000000000


Kernel is the 'mainline' branch of git://neil.brown.name/gta04 (commit
  388c9f46f9d566bd7f7dd6acb45c113c59c11417)

This is 3.7 plus a bunch of fixes and additions to make it all mostly work =
on
this board (Panel driver, audio glue, sdio wifi fixes, sensor drivers, bug
fixes, etc etc etc).

Thanks,
NeilBrown

--Sig_/4hTXp8p7htz0zAtamWuQcyv
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUPhoUjnsnt1WYoG5AQKAmw//Z7VRZPH/73KnfLFbfBjQgMLQoPh2Twbg
6NJUAUIrY9C2MBg/Ws43ZSLqcbo9RPIPv7seBPkMA3ARzJ3JimgRUUK6nrQXmZTl
/F/2Pv67zUqvzPvFfMe5sZigt44bPdYoCghFTiLAp2tVPQn+HWScYZER2YWMvT6F
HQGi1vMfXvfM4BwACMaNC8AzrOnkDYmzS7US+2wJtSFsMHiVaCMZpgGjIaA9tZ8M
P9uM8dog1L5wYr79xloh/HNAk3mQ2aRvWY6+FCg7zKhdMG1eenq3YSUy7mXVzbya
cHkKQQRH9HH7UYIITy7ZLRBWkzHlcSdd1e2kGJxZQe8A3cV+dXajhAr4HFaNpdxd
Pvr8vr6RW7cMzstqbfZFfDk3cufu2q0JlALlHluwwl56cJCr7R4Lyr5xyLPTmcpf
6TV+otMcdeQydpVVAGAoDePDk5UFk4hbWoPM++NIsM0qCmCimTWBUwBEDfdQ1g4D
HttTKOLogM2ekyqDj2e/HrB05g4AnySxqCYUnq0YtPmTXghYIJxSzD8fefkEtoGg
c60ZvwERzakd9YxVFasMO8GGXLocFCyXZWGpvKYcyZerc2ObHRnRIBUAi3vN+ccK
wozTtt/oBNfv3OCwPRgugJxOYIk0gIhFl1gATMMoLFAZFZQi/LModlnb87s0XYA/
BdwEo8cMSW4=
=OGq1
-----END PGP SIGNATURE-----

--Sig_/4hTXp8p7htz0zAtamWuQcyv--
