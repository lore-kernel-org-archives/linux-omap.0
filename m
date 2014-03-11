From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Date: Tue, 11 Mar 2014 12:15:55 +0200
Message-ID: <531EE25B.9060201@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com> <20140307164929.GC3789@atomide.com>
 <531DBCA8.80507@ti.com> <20140310154105.GA4882@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7022144179258747413=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140310154105.GA4882@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Enric Balletbo Serra <eballetbo@gmail.com>, Sebastian Reichel <sre@debian.org>, Javier Martinez Canillas <javier@dowhile0.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Darren Etheridge <detheridge@ti.com>, Sebastian Reichel <sre@ring0.de>, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Stefan Roese <stefan.roese@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7022144179258747413==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0jS77HPcbMP45IgPpMbtlbSmRp18IgQsu"

--0jS77HPcbMP45IgPpMbtlbSmRp18IgQsu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/03/14 17:41, Tony Lindgren wrote:

>>> How about do a pull request for just the .dts changes against current=

>>> omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is ass=
uming
>>> that just the .dts changes alone won't break anything.
>>
>> Unfortunately they do break. At least pinmuxing is moved from the glob=
al
>> definitions to be handled by the respective display drivers, and there=

>> are some regulator_name hacks that the DT patches remove.
>=20
> OK. Will that cause regressions for omap3 as that's still also booting
> in legacy mode?

No, I don't think so. The problems revolve around the pdata-quirks, with
current DSS support when booting with DT. It's rather difficult to split
the series so that it could be merged freely in multiple parts.

If I split the series into three parts: 1) .dts changes 2) main DSS DT
changes 3) removal of pdata-quirks etc, I run into problems. Both 1) and
2) work fine individually, but when both are merged, there are two
competing systems, the proper DT stuff and the pdata-quirks stuff. And I
haven't found out a simple way to manage that, as the whole display
support is split into multiple independent devices.

One option would be to combine 1) and 3), so that when they are merged,
there would be proper DT data, and the pdata-quirks would be removed so
that it wouldn't be messing everything up. But that would, of course,
mean that after merging 1+3, the display wouldn't work on those boards
that rely on pdata-quirks, until 2) is merged.

>> I think those changes could be removed from my patches, and then added=

>> back later when everything else has been merged.
>=20
> Or you could have a second branch that also merges in omap-for-v3.15/dt=

> branch that you can send later towards the merge window after the arm-s=
oc
> changes have been merged. If you want to do that, then feel free to add=

> my ack also for the .dts changes:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> If however those changes get postponed to v3.16, it's best that you'll
> redo the branch as I'm sure we'll have other merge issues for v3.16.

Ok. At the moment I feel that the easiest option would be to keep the
DSS DT series as it is, but merge omap-for-v3.15/dt to it and solve the
conflicts. I'd keep that branch separate from the fbdev changes, so that
I could send the DSS DT pull request later, when arm-soc has been pulled.=


>> The bigger issue is that suddenly there's lots of discussion about the=

>> display DT bindings. If those are not resolved very soon, I guess I ha=
ve
>> no choice but to again skip the merge window for the DSS DT changes.
>=20
> OK, some of these more bindings can take easily six months to reach
> some kind of resolution. You may be able to use TI specific unstable
> bindings meanwhile if that makese sense.

Yep. I don't know... If the whole port/endpoint system that I currently
use is changed totally, it might be painful to support both the TI
specific bindings with the old format and the newer format.

 Tomi



--0jS77HPcbMP45IgPpMbtlbSmRp18IgQsu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHuJbAAoJEPo9qoy8lh71lLcQAINQfS70GwOQbLaDlq+qupBw
Y7GjtMiZSpc2u+SKOPKxC0U1MvUn6u0QB7NK+vm1H8REt4v0jNhIgG/ODovY2UNE
cGjPrwQoSqAtGdZktIrUIwuSJEZT0o6ZCpV2PLv1CSAEuLxkay6SwS/fSfC/kfnK
9hKbg0v1VfOyQiBAkBhG433m2nss81TS9gCf1JdT/gPGEG7Y8uQapLHASDCXnKme
ykOfNw9WItTZ1qs5pRT5D1wRl+uPat+Q0t//zybx7H1DMcs6zXl4wfrZFPFw/Bi5
enUYfSJkfRvjiIQ2igFtX8hlHIut32iJg6P0f2zeNx8St38lMTJfHjer+GbR2twl
CRoJFb87xDXPkxSjjynF75q64wXLJMaQ1yRoBCh4LX7J9VqPHZOFi0pWJyoj/kjg
VrRnG84hYfxlwUM556IDL99GZn0rgbXES4MBd0BUX8ziUCxlQNf0IInGhJuLwZuH
yzdA0+knXGcoL1bwPj1coECwo3rnaUCzlXEuTBVRj+lUvx65OAWoxp7wccotYt+h
kn0QnYHgXkZeujilkSe7E8O0JTrW19l2wHnYd+TgfGsXMao24okqL9HYCqgX0Ezb
8is1vScvWAdqoahfSm7yT8AHccUYAXxij8NnFmyq3dgvxRzHpeSpBtPO12RN8zGB
6Za5vAop8I2BnpDpmFbD
=zlq3
-----END PGP SIGNATURE-----

--0jS77HPcbMP45IgPpMbtlbSmRp18IgQsu--


--===============7022144179258747413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7022144179258747413==--
