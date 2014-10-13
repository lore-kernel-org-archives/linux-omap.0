From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 03/12] rtc: omap: fix class-device registration
Date: Mon, 13 Oct 2014 10:57:07 -0500
Message-ID: <20141013155707.GH21709@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-4-git-send-email-johan@kernel.org>
 <20141010175919.GO31348@saruman> <20141011095947.GB18988@localhost>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5694704704566830498=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141011095947.GB18988@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, t-kristo@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

--===============5694704704566830498==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline

--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 11, 2014 at 11:59:47AM +0200, Johan Hovold wrote:
> > > @@ -450,14 +441,14 @@ static int __init omap_rtc_probe(struct platfor=
m_device *pdev)
> > > =20
> > >  	/* handle periodic and alarm irqs */
> > >  	if (devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
> > > -			dev_name(&rtc->dev), rtc)) {
> > > +			dev_name(&pdev->dev), pdev)) {
> > >  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
> > >  			pdev->name, omap_rtc_timer);
> > >  		goto fail0;
> > >  	}
> > >  	if ((omap_rtc_timer !=3D omap_rtc_alarm) &&
> > >  		(devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
> > > -			dev_name(&rtc->dev), rtc))) {
> > > +			dev_name(&pdev->dev), pdev))) {
> >=20
> > i don't get it. Why pass pdev as cookie when all you need is rtc ?
> > Doesn't sound very good to me. Also, IRQ handler *must* be registered
> > only after RTC is registered. That's because if you request an IRQ here,
> > you could already have a pending interrupt and since you won't have a
> > valid rtc pointer you won't be able to clear the interrupt line.
>=20
> We don't need the class device (rtc pointer) to clear the interrupt
> line. The iomem base is enough, and that is static until Lokesh adds the
> struct omap_rtc_dev abstraction. Then we pass that as the cookie.

I wonder how that patch will look like ;-)

> And all RTC interrupts have been disabled, and pending interrupts
> cleared before registering the handlers so that should not be a problem.
>=20
> To the contrary, once the class device has been registered user-space
> could enable interrupts at any time and that is why everything should
> have been set up before.

alright, got it. Thanks

--=20
balbi

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUO/ZTAAoJEIaOsuA1yqREX2YQAISJkbdj9LvlLe7tZSIGuarp
NDlfDeTVp4sUbCMaR4MBT/ROQAF1sw96JC+xjDSEHQNkiLsJSVCt+j8U/HUvoTi5
omsDTrJtNhTWuAGHXIO+e1pUQlCta6efXWdP/6sCXSb28OMHiFARK0ee//+dOFRy
0jQsp/Dg8dK4zH6eflxfQrr2mVbFRallq6bj1St+LiKX+SIhayyKYRHBXq93kzEG
dcpt3MKtL62aYMCD/gGbS1/QAuP7Y9/6uCNw9OHf4Ekd+24YeWJGp7Ez/ZZTBymK
yvXfe8T7lanUrPU+Cnnolyd67sdp7lDUYmWzqiSD7/BzQcDLRibQjj3cNCp5GHz5
RR8Pq3KuoUlthzbyKYpnWG50exm4uz7yixjTn609KOQ3E5qLxXgcy3Zw9CmuylXo
W7BKWffHJFYEWdZz4onDbQLZ6Xlf28Y44yhRBO5D6cK2GrTuJ5Kl6lYgF09hYCHa
/0SFmEBXkcyiW2wD7tl4A6wEJZ9fG11Jxg90DNl9rSoX/D6OXo2uspprJ7zyZ/Pp
CuawpYi/M8vCIadFRV4d9uNu5QHj31VrAmR6TanddH562za8KXpgMLK71n2zo1Ap
D+me7jRLM4BIqMErnvEzYjUJePBDN6WSPKtbfgTq6k4zWr2QZAPMs4UlbpB2XAWn
56Ni+MgytrVzNDzXcFSI
=NIq4
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--


--===============5694704704566830498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5694704704566830498==--
