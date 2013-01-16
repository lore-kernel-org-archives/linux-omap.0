From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 21:27:15 +1100
Message-ID: <20130116212715.2567d5ed@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50F67A50.5020203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/.FjYH1Gm=c0LBAPl1K3Fvtt"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42476 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758678Ab3APK12 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 05:27:28 -0500
In-Reply-To: <50F67A50.5020203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/.FjYH1Gm=c0LBAPl1K3Fvtt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jan 2013 12:00:48 +0200 Roger Quadros <rogerq@ti.com> wrote:

> On 01/09/2013 12:29 AM, NeilBrown wrote:
> >=20
> > Hi,
> >  I'm trying to get off_mode working reliably on my gta04 mobile phone.
> >=20
> > My current stumbling block is USB.  The "Option" GSM module is attached=
 via
> > USB (there is a separate transceiver chip attached to port 1 which is p=
laced
> > in OMAP_EHCI_PORT_MODE_PHY).
> >=20
> > After a suspend/resume cycle with off_mode enabled the GSM module disap=
pears.
> > i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices do=
n't
> > exist.
> > Without off mode, the modem always appears after resume.
> >=20
> > I discovered that the registers set by:
> >=20
> >    drivers/mfd/omap-usb-host.c
> >=20
> > are not maintained across as suspend/resume so I added the following pa=
tch
> > (which I can make a formal submission of if it looks right to others), =
but
> > that didn't help (or didn't help enough).
> >=20
> > If I
> >=20
> >   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
> >=20
> > thus keeping just the USBHOST power domain out of off_mode, the GSM mod=
ule
> > doesn't disappear.  So it seems that some context in the usbhost domain=
 is
> > not being save and restored.
> >=20
> > This is as far as I can get.  Can someone suggest where I should look t=
o find
> > out what is not being saved/restored properly, and how to go about savi=
ng and
> > restoring?
>=20
> You need to ensure that USBHOST/TLL context is saved as per the Save and
> Restore sequence see section "USBHOST/USBTLL Save-and-Restore
> Management" in the OMAP Technical Reference Manual.
>=20
> The basic idea there is that software does the context saving into SAR
> RAM before entering OFF mode and hardware automatically restores the
> context after coming out of OFF mode.

Is it?  The way I read the doco, the hardware both saves to SAR RAM, and
restores from  SAR RAM.
  Section 22.2.4.1.6  Save and Restore
of my copy of the TRM says:

> The save-and-restore (SAR) mechanism can extract the hardware context of =
the high-speed USB host
> controller (after all USB activity has been suspended) before switching o=
ff (=3Dsave), save it to an external
> always-on memory, and reinject it later after the module has been switche=
d on again and reset (=3Drestore)
> seamlessly for the USB. Part of that context is composed of the register =
fields described in the current
> chapter. The rest of the context is composed of the "buried" flip-flops a=
nd memories (not accessible by
> software) like finite state-machine (FSM) states, buffer contents, and mi=
scellaneous random logic bits.

which strongly suggests that it is all handled by hardware.  Of course there
are other registers that aren't covered  by the SAR - we need to identify
those and make sure they are saved and restored.  I've found a few registers
that aren't being restored, but restoring them hasn't made a visible
difference yet.

Am I missing something?

>=20
> But that alone is not enough for USB host to work. We need to make sure
> we have covered all the erratas. There are a number of them which are
> not covered yet in mainline.

Is there a list somewhere?

>=20
> USB remote wakeup is another challenge with OMAP USB host (while in OFF
> mode). The usual workaround here is to use a GPIO as a wakeup line from
> the modem.

Yes, this is not a problem for my device.  There is a GPIO line which signa=
ls
and incoming SMS or Call and it successfully wakes the device.

>=20
> regards,
> -roger

Thanks,
NeilBrown

--Sig_/.FjYH1Gm=c0LBAPl1K3Fvtt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUPaAgznsnt1WYoG5AQKX9Q//VHZ3ufDpGd+A4VEl5f9NNg7th9fzE3yw
hEtOFIA1+DZ9ld3f/lgH61UPKbMmoOFK5kljOz3gwBCV4dRp73a9Lduo20QcmoI3
18QyWzYAcuDW46haetVstryh9Ar0R08IbXnh13rQztfrtglD/UDXL31EN79nK9g/
urk5TTKlGywoTi9Mlwzso1QE184Xbil8eX0YjcHZuhLc3U5IJzooo/6BdXBKqQe0
qygdLHljBJtoQZHQFgE7UtPixtz3Ko1UqpBr8lBtlR5N2NUfEG1ONclE7Z/u4eDd
FDX0udjtxUzhr+wyXQvBjPFmZHshJYdQKoBpI9qmaggydPrwqCM0GBTZuqCU6VF+
28ayEP+AeWJ+vCnj2m9qWjCFesTNIqV9JG6EkbqUIHSaZXcIConfQA6+LUTdwksP
dGKaTkYYjTyru852kTkBGFgoL96l4cAwcRycqBrGKOfVBI0/7NhtAzm0Zmo15dkW
VeliTsfwzutY/SxghfQbfgk8Ve+ViJyyB5mBXQCFwq41FWy/Dpqql4bfS0CkEXCy
rUy4B1tt5AIi0uqre8hLzEraybUhnB4mSUm93TsL7FbZb6+b5sj9BVNhxT8+tEZZ
Cf645t+foy0rzu8ATuV49s7eLyOI/xNnL7ekHSgnRSs/6IhCv21YYHS8C44CMf6C
ASkb89X+A8s=
=Ry5b
-----END PGP SIGNATURE-----

--Sig_/.FjYH1Gm=c0LBAPl1K3Fvtt--
