From: "Reizer, Eyal" <eyalr@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8
   support
Date: Thu, 3 May 2018 06:41:19 +0000
Message-ID: <5cc906da15da45ab96e06957f878b65b@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <20180502145100.GK98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502145100.GK98604@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalreizer@gmail.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>=20
> * Eyal Reizer <eyalreizer@gmail.com> [180501 00:26]:
> > enable mmc3 used for wlan and uart1 used for bluetooth
> > configure the gpios used for wlan and bluetooth controls
> > add fixed voltage regulator used for wlan power control
> ...
> >  / {
> >  	model =3D "TI AM437x SK EVM";
> > @@ -158,6 +159,22 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	vmmcwl_fixed: fixedregulator-mmcwl {
> > +		/*
> > +		 * WL_EN is not SDIO standard compliant. It is an out of band
> > +		 * signal and hard to be dealt with in a standard way by the
> > +		 * SDIO core driver.
> > +		 * So modelling the WL_EN line as a regulator was a natural
> > +		 * choice as the MMC core already deals with MMC supplies.
> > +		 */
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "vmmcwl_fixed";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		gpio =3D <&gpio4 8 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> >  };
>=20
> Interesting that it needs much longer delay here compared to the
> earlier?

Where do you see a delay in here?
There is no startup-delay-us value used in this patch.

>=20
> BTW, I do have a patch in work to add pwrseq support for wlcore that
> allows leaving out the regulator here. It still needs a bit more
> work though.
>=20
> And I also have a series in work to make wlcore use runtime PM that
> needs even more work, just FYI to avoid any duplicate work.
>=20
> Hmm you don't happen to have a patch series somewhere making
> wlcore use the SDIO dat lien interrupt?
wilink has always used out of band interrupt (using wlan_irq gpio).
in-band interrupts was not supported.
See section 10.5.2 in this the wl18xx hardware integration guide:
http://www.ti.com/lit/ug/swru437/swru437.pdf

>=20
> I think we should use that when idle rather than the (edge) gpio
> interrupt as the SDIO dat interrupt is level sensitive and wired
> to the always on gpio bank for most SDIO controller instances.
> On runtime PM wakeup, there's no status anywhere to been with the
> GPIO edge interrupt.
>=20
I agree that it would have been better, especially for cases such as wake=20
On wlan, but again, in-band interrupt was something that was talked=20
about way back but it was never implemented.

Best Regards,
Eyal
