From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/2] ARM: devicetree: Remove unused ti,codec property
Date: Mon, 16 Mar 2015 15:20:44 -0700
Message-ID: <20150316222044.GR12397@atomide.com>
References: <1426279237-15940-1-git-send-email-marek@goldelico.com>
 <55068350.9080500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55068350.9080500-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150316 00:16]:
> On 03/13/2015 10:40 PM, Marek Belisko wrote:
> > ti,codec in not parsed in omap-twl4030 sound driver. It's not neces=
sary
> > to specify this property in DT because ti,twl4030-audio which ti,co=
dec
> > was pointing to by phandle is mfd driver and device for ASoC ic cre=
ated w/o
> > any DT property (codec name is hardcoded in ASoC driver).
> >=20
> > Please see reply [1] from Peter Ujfalusi.
>=20
> All:
> Acked-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Applying both into omap-for-v4.1/dt thanks.

Tony=20
=20
> > Changes from v1:
> > - keep ti,codec property in Documentation as optional that the
> > existing dtbs do not become noncompliant after the change
> >=20
> > [1]: http://comments.gmane.org/gmane.linux.ports.arm.omap/124273
> >=20
> > Marek Belisko (2):
> >   ARM: dts: omap3: Remove all references to ti,codec property
> >   Documentation: omap-twl4030: Move ti,codec property to optional
> >=20
> >  Documentation/devicetree/bindings/sound/omap-twl4030.txt | 3 +--
> >  arch/arm/boot/dts/omap3-beagle-xm.dts                    | 1 -
> >  arch/arm/boot/dts/omap3-beagle.dts                       | 1 -
> >  arch/arm/boot/dts/omap3-cm-t3x30.dtsi                    | 1 -
> >  arch/arm/boot/dts/omap3-devkit8000.dts                   | 1 -
> >  arch/arm/boot/dts/omap3-gta04.dtsi                       | 1 -
> >  arch/arm/boot/dts/omap3-igep.dtsi                        | 1 -
> >  arch/arm/boot/dts/omap3-lilly-a83x.dtsi                  | 1 -
> >  arch/arm/boot/dts/omap3-overo-base.dtsi                  | 1 -
> >  arch/arm/boot/dts/omap3-tao3530.dtsi                     | 1 -
> >  10 files changed, 1 insertion(+), 11 deletions(-)
> >=20
>=20
>=20
> --=20
> P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
