From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: remove *.auto* from device names given in
 usb_bind_phy
Date: Tue, 30 Jul 2013 09:18:30 +0300
Message-ID: <20130730061830.GE9155@radagast>
References: <1374829418-27503-1-git-send-email-kishon@ti.com>
 <1374829418-27503-3-git-send-email-kishon@ti.com>
 <20130729150638.GD3063@radagast> <51F68A56.8060805@ti.com>
 <20130729175413.GC4964@radagast> <51F74BC8.7020903@ti.com>
 <20130730060134.GD9155@radagast> <51F7590B.4020705@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7031257187334862175=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7590B.4020705@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, eballetbo@gmail.com, javier@dowhile0.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7031257187334862175==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2013 at 11:41:23AM +0530, Kishon Vijay Abraham I wrote:
> >>>>>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-o=
map2/board-2430sdp.c
> >>>>>> index 244d8a5..17bb076 100644
> >>>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
> >>>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> >>>>>> @@ -233,7 +233,7 @@ static void __init omap_2430sdp_init(void)
> >>>>>>  	omap_hsmmc_init(mmc);
> >>>>>> =20
> >>>>>>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
> >>>>>> -	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> >>>>>> +	usb_bind_phy("musb-hdrc.0", 0, "twl4030_usb");
> >>>>>
> >>>>> how about moving usb_bind_phy() calls to omap2430.c ?
> >>>>>
> >>>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap243=
0.c
> >>>>> index f44e8b5..b6abc1a 100644
> >>>>> --- a/drivers/usb/musb/omap2430.c
> >>>>> +++ b/drivers/usb/musb/omap2430.c
> >>>>> @@ -544,6 +544,9 @@ static int omap2430_probe(struct platform_devic=
e *pdev)
> >>>>> =20
> >>>>>  		pdata->board_data	=3D data;
> >>>>>  		pdata->config		=3D config;
> >>>>> +	} else {
> >>>>> +		/* bind the PHY */
> >>>>> +		usb_bind_phy(dev_name(&musb->dev), 0, "twl4030_usb");
> >>>>
> >>>> This looks like a hack IMHO to workaround the usb phy library. other=
wise it is
> >>>> similar to get_phy_by_name.
> >>>
> >>> actually, this is a workaround to the fact that we're not creating all
> >>> platform_devices in arch/arm/mach-omap2/ :-)
> >>>
> >>> If we had the musb allocation there, we could easily handle
> >>> usb_bind_phy()
> >>>
> >>>>> so that's temporary. It might be better than to reintroduce the IDR=
 in
> >>>>> musb_core.c.
> >>>>
> >>>> that=E2=80=99s needed for generic phy framework anyway :-s
> >>>
> >>> right, but generic phy framework can handle everything just fine, the
> >>> only problem is that names are changing.
> >>
> >> right. But if the names change, PHY framework wouldn't be able to retu=
rn the
> >> reference to the PHY.
> >=20
> > with my suggestion they can change whenever they want since we're using
> > dev_name() of the just-created musb platform_device. Right ?
>=20
> right. But the PHY device can be created in a different place from where =
the
> musb devices are created. And in the PHY framework, the PHY device should=
 have

this shouldn't be a problem. As long as the phy is created, all should
be good.

> the list of controller device (names) it can support (PHY framework does =
not
> maintain a separate list for binding like how we had in USB PHY library).=
 e.g.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92817.html. In =
such

this has nothing to do with $subject though. We talk about generic PHY
framework once all these PHY drivers are moved there :-)

> cases how do we pass the device names. Also will the MUSB core device be
> created before twl4030-usb PHY device?

and why would that be a problem ? We're telling the framework that the
musb device will use a phy with a name of 'twl4030'. If musb calls
usb_get_phy_dev() and doesn't find a phy, it'll return -EPROBE_DEFER and
try again later.

--=20
balbi

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR91q2AAoJEIaOsuA1yqREarEQAKCyKybza8MV5jQZzXk0gnx8
aF3vzAfGjeHYUGbsfUXWaO0JI+t/UNwnvufGfODGnDhtnLbt+vI4ryJ396YlEjSQ
3p2VB6Ck7/ciZR/bUvpWe0lyADLqYTiK35wRxvf+revoXmpRZYGO25nSBK8Bt7kg
T9e8+HOTfSOYcM9fbvK50i+5HLpsA97I9Nz/1LA6aQlwxKipARnIZXrx0gqceA8W
mUhHBrZnAfsCb5KA7swYwasLPVgv0D0WhS5e3k1+MhnoCSlmhTQgqybeY4VZpIAp
9mk6AK/StESPxM+kmy2k4R5YymiWX4lxHfcWg97S2X7NgCIckaNxBAYjj8+qBSly
+/0tjkoMMEPAQG4HJlfUiQAEq4irXwIZASWfmbR30qLG9R1w+ssyrCXEnXV0LXmA
Uv5p1p4vLkjxay+33EJ2zk5C98Ut7Yai5pGHOVsu7OrmxTzb4WPom79IklXjGiWh
GTbUpr2CG9DtzPevT2U+zuJc/jMXakG/eUzG4zpVnlpiIf4f++H3ux3dQTSYLxiT
dpTAX8cwEmb2qJIgQ+If46zZHFoXU+F8xs1Lm+lgeBebAm15h7x7daZzBiBgelXQ
FHjhV1uOpy+n8jXmobOfHnInycjIRS1WJEIK7hIdVl3FmbThbk0jYRt6qPz61zEm
1dcr+mzbtNUyq0PmvNBT
=yaip
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--


--===============7031257187334862175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7031257187334862175==--
