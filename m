From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v2] musb: omap2430: do not assume
 balanced enable()/disable()
Date: Tue, 9 Aug 2016 07:35:59 +0200
Message-ID: <20160809073559.287d0a59@aktux>
References: <1470238731-32358-1-git-send-email-andreas@kemnade.info>
	<FFDA9A63-599B-44CA-B244-C8860D9E01D9@goldelico.com>
	<20160804142919.GG28140@atomide.com>
	<20160804183129.2e0cac71@aktux>
	<20160804184402.73963e8a@aktux>
	<20160805135501.GJ28140@atomide.com>
	<20160805172039.6dac0aeb@aktux>
	<20160806062134.GK28140@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X8+mAmNIp7E.KfluvnTTApj"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160806062134.GK28140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap <linux-omap@vger.kernel.org>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/X8+mAmNIp7E.KfluvnTTApj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Aug 2016 23:21:35 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [160805 08:35]:
> > I repeat the subject line of the patch:
> > [PATCH v2] musb: omap2430: do not assume balanced enable()/disable()
> > It is *not* fix charging.
> >=20
> > So you mean that the phy should magically know at which refcounter
> > it should power on and off if power on/off is not called in the
> > balanced way?
>=20
> No, I mean we need to figure out why things can be called in
> unbalanced way. With your patch I end up with unbalanced calls
> leaving the phy on after all the modules have been removed :)
>=20
Well, causing trouble when modules are removed was not the intention.
I was just happy to have things working a bit again.
The phy is powered on/off via
musb_platform_enable()/musb_platform_disable().

Calls to musb_platform_enable() occur at only 1 place.
musb_platform_disable() is called at 4 places.

about balancing:
There is musb_start() and musb_stop(). They are called from
musb_gadget_start/stop()
These call musb_platform_enable() and musb_platform_disable().
Looks ok.

There is musb_suspend() and musb_resume():

musb_suspend() calls musb_platform_disable()
musb_resume() calls musb_plaform_enable() via musb_start()
looks balanced but why don't we use musb_stop() in musb_suspend()?

Now the odd things:
musb_platform_disable() in musb_remove() called upon module removal
musb_platform_disable() in musb_init_controller() called from
musb_probe()

This looks clearly unbalanced.


> > Maybe the phy-twl4030 uses the phy layer wrong.=20
> > Now the relevant part of power on/off in phy-twl4030 is done via
> > struct phy_ops.power_off/power_on (*not* via pm_runtime). Maybe
> > that is wrong and more parts should be moved to the pm_runtime
> > stuff (which is also present).=20
>=20
> We should use phy power_off/power_on for the USB related parts.
> The parts needed by other components, like VBUS detection, should
> be handled by PM runtime. We should get phy-twl4030-usb and the
> charger driver working also when no musb modules are loaded.
>=20
> > Then the phy subsystem has its own power refcounter in struct
> > phy.power_count. It it handled via phy_power_off()/phy_power_on().
> > And that is called from musb/omap2430.c=20
> > But that is another story.=20
>=20
> Yes that's what the USB driver is expected to do. But obviously
> there are issues remaining also in the phy-twl4030-usb.c driver.
> And it seems that we should have some OTG parts always enabled
> when VBUS is detected when twl4030-charger is configured?
>=20
Seems so. I am writing a patch for it.

> > > If there are MUSB specific PM runtime issues then let's fix
> > > those separately.
> > >=20
> > And that exactly tries my patch to do. For that task it does not
> > even use the PM runtime system. Again please read the subject line
> > of the patch. Maybe it unveils some other pm issues in musb
> > which should first be fixed in a complete patch series.
>=20
> Certainly that needs to be fixed, but let's do it in a way where
> things work for other test cases also. Care to describe how to
> to reproduce the issue you're seeing? It seems that you are
> seeing devices not being enmerated leading to the charger not
> working? Is this with built in MUSB and phy modules?
>=20
Both as modules. I added some debug output to the driver/phy/phy-core.c
and have seen the phy->power_count sticking at -1 or 0.=20
g_ether is also loaded.
Gadget stops for me (device not showing up at the other side) at 4.7rc4.
But I remember Nikolaus having the situation on the same type of device
that it was important on which side you replug the usb cable
(probably causing some timing differences) with 4.7rc1.

Regards,
Andreas

--Sig_/X8+mAmNIp7E.KfluvnTTApj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqWu/AAoJEInxNTv1CwY0sCoP/Alg5GDRVwjtUXl5hvULJscp
a2kGykaf6KmMSemyh3jbqZJLocd33fgj6KxAr8IhGirdhAe5jCVNtEScpMgKY1J2
XTSl6qfSdGDACRgjr0NiqtLJSxWLAmkuftrgkR5j3tqBZEVaQMNs/QnKJFUkOtbM
o5/dVEpUU3NXjTmmhTIqdydZQmaeL4s/OxmnEe+5sddHqyBGWM+/g/Zq82jmwV+0
a+Y0zv49mtcZVr7IyUs4S++0dDRntOhI0S+9KK/mInujlWuzLlZL2I0byidKarFC
AaGt/MlhpzTpWcmfPDjWFiC+uE492L3kqRHhV/Bx4feh/4KjHAiwh+lSHxUqky3S
9tOiZ5QOEclAEKEjwqsSHI3cu9fz8+Ht0swKQ2THEFmQboSRmtCz0xMy38VjxwsS
KctluJq7At+66ELkNKnQje+nsfN8sfVTR7/PrcMYbESB0dMfAJlOoIux2/q+MpKG
62ipzK2WiOmgoDAjLq6aXllV6jWCnIhDTC439QFJt/MrP7OIDv1oBEq7qyxD+Go8
XMLo1OaI9U75Q345NrVe9RXmVRt0xBRhbSiSgHj3ZvHjQoxN8rhs/XWU8Vi2YEqP
I/wxm9EKife1w0IosPGILeWhE0mSYxWHeW4AavwZOAlO/IeKEtWraUYVe1BnPbS8
BV/HghAmo5bfZAQR0DVW
=IcS+
-----END PGP SIGNATURE-----

--Sig_/X8+mAmNIp7E.KfluvnTTApj--
