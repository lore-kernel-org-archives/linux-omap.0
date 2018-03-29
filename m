From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 20:05:41 +0200
Message-ID: <20180329180541.GA26545@amd>
References: <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com> <20180329160828.GA14007@amd>
 <20180329163450.GQ5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4839443310609181135=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180329163450.GQ5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============4839443310609181135==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-03-29 09:34:50, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180329 16:09]:
> > > Then using the n_gsm ts 27.010 uart mux, I dial:
> > >=20
> > > ./ngsm-rw 1 "AT+CFUN=3D1"		# connect to network
> > > U0001+CFUN:OK
> > > ./ngsm-rw 2 "AT+CMUT=3D0"		# unmute speaker over ch2, do this over qm=
i?
> > > U0001+CMUT:OK
> > > ./ngsm-rw 1 "ATD#123"		# dial number
> > > U0001D:OK
> > >=20
> > > And I do hear a voice talking over the speakerphone :) Sorry have not=
 tested the
> > > mic yet..
> >=20
> > Hehe, ok, that's fun! I don't need +CMUT=3D0. It gave me error but then
> > the call worked, anyway... (I'm working with ttyUSB4).
>=20
> Oh interesting. So maybe Android is doing AT+CMUT=3D0 for some other
> modems and it's not really needed? Or you have settings preserved
> from warm boot from Android?

No idea. But I booted from recovery, and I had to power up modem using
+CFUN...

> I did not have any luck with ttyUSB4 last night. Did you dial with
> ATD123; or ATD123? So is the semicolon really needed?
>

AT+CFUN=3D1
OK
ATD800123456
NO CARRIER
ATD800123456;
OK

I seem to need semicolon. And yes, I tried again after the call. Still
says no carrier.

Hmm. And when calling test number, the modem failed:
>
[  438.236755] Somebody do a proper driver please cpcap_soc_work
[  495.496032] phy-mapphone-mdm6600 usb-phy@1: modem status: 0 off
[  499.406005] phy-mapphone-mdm6600 usb-phy@1: modem status: 0 off
[  499.407318] usb 2-1: USB disconnect, device number 2
[  499.424926] qcserial ttyUSB0: Qualcomm USB modem converter now
disconnected from ttyUSB0
[  499.434112] qcserial 2-1:1.0: device disconnected
[  499.443389] qcserial ttyUSB1: Qualcomm USB modem converter now
disconnected from ttyUSB1
[  499.451904] qcserial 2-1:1.1: device disconnected
[  499.460968] qcserial ttyUSB2: Qualcomm USB modem converter now
disconnected from ttyUSB2
[  499.469512] qcserial 2-1:1.2: device disconnected
[  499.478057] qcserial ttyUSB3: Qualcomm USB modem converter now
disconnected from ttyUSB3
[  499.486572] qcserial 2-1:1.3: device disconnected
[  499.504760] qcserial ttyUSB4: Qualcomm USB modem converter now
disconnected from ttyUSB4
[  499.513244] qcserial 2-1:1.4: device disconnected
[  499.519104] qmi_wwan 2-1:1.5 wwan0: unregister 'qmi_wwan'
usb-4a064800.ohci-1, WWAN/QMI device
[  499.611511] qmi_wwan 2-1:1.6 wwan1: unregister 'qmi_wwan'
usb-4a064800.ohci-1, WWAN/QMI device
[  499.676086] Somebody do a proper driver please cpcap_soc_work
[  499.688323] qmi_wwan 2-1:1.7 wwan2: unregister 'qmi_wwan'
usb-4a064800.ohci-1, WWAN/QMI device
[  499.768859] qmi_wwan 2-1:1.8 wwan3: unregister 'qmi_wwan'
usb-4a064800.ohci-1, WWAN/QMI device

That one will be fun to debug, I'm afraid. (Or does the message at
495.496032 mean that we turned it off?)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq9KvUACgkQMOfwapXb+vI3aACeMTD7Ccii/NsR4dxiS/2u9eAH
6nIAoLWmdDoXg6IwiSLMkYtvm9hw0jMZ
=W3nw
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============4839443310609181135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4839443310609181135==--
