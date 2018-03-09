From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec
	support
Date: Fri, 9 Mar 2018 12:19:38 +0100
Message-ID: <20180309111938.irzwypdehuckx35s@earth.universe>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
 <20180308112528.GC6019@sirena.org.uk>
 <20180309083414.s57eq3kw325magwz@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6561208670344405679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180309083414.s57eq3kw325magwz@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============6561208670344405679==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivv5fbufhe273ms5"
Content-Disposition: inline


--ivv5fbufhe273ms5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:34:14AM +0000, Lee Jones wrote:
> On Thu, 08 Mar 2018, Mark Brown wrote:
>=20
> > On Thu, Mar 08, 2018 at 10:48:31AM +0000, Lee Jones wrote:
> > > On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> >=20
> > > > I had it in PATCHv1-PATCHv4. It was removed, since Mark didn't want
> > > > to have it in the DT ABI.
> >=20
> > > Right, but why?  Is it not a hardware device?  I think converting from
> > > devm_of_platform_populate() for one sub-device is a bit drastic.
> >=20
> > It's not a separate physical device or IP and doesn't exist outside of
> > the MFD, it's just how Linux is currently choosing to divide up the chip
> > right now but that's totally open to change even in future versions of
> > Linux.  Clocks are a big issue with audio stuff, right now sections of
> > the clock tree get handled in the CODEC driver but we're going to want
> > to push them out to a clock driver so we're not reimplementing handling
> > for clocks.
>=20
> How is the CODEC controlled?  Does it have its own registers?  I guess
> by "it's not a separate device or IP" you mean that it doesn't.  But
> that begs the question, how does this then device differ from all the
> other devices (adc, battery, charger, regulator, rtc, pwrbutton,
> usb-phy and led)?

The audio codec goes from register 0x0800 - 0x0844, with the next
register being defined @ 0x0a00. So it definetly has its own register
range. I should note though, that 0x0800 is the audio regulator
control. In Linux we handle this one in the regulator driver instead
of in the audio driver. But this is mostly hidden in DT (the voltage
ranges for VAUDIO are described in the regulator node now).

> I'm asking, not to be awkward, but to avoid 50 lines of potentially
> unnecessary static code.  If this is a real (sub-)device, even if it's
> part of a larger, single device (MFD) then there is no reason why it
> can't be represented as a single, albeit empty node.

We still have the node, so that it can be used with the ASoC graph
binding. It just has no compatible value. Instead it is identified
by the node's name.

-- Sebastian

--ivv5fbufhe273ms5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqibcIACgkQ2O7X88g7
+poGPQ//dQYd94GdQfmyfdDyXAC/omHEGe7FldYHVAVPT6AzxYAOKg4ngjLd7JC1
07m/jJTSzutPBNkwFvqn5FoTscZOeWobnEQThZpSaCfsyKu+rj6p1NgUUMSXhjCd
kwQVvMmnqBWSOLVaRYsYsGpCC5wAUTzZR7eSDy0IQ8QJ0yQ/3PVOgclQYkPtgOiY
PcoKiFKNFXE1jz265Vi5UkHw87iMMJT5i6cbd2jrZX/TZ99cSjRXUXA4op3PRFaa
3S2UNbcanZfA+hWEdrkM+6v1lPViUSo5paH7zV9Z8Jk8xlc+djfMiBSRyFUfJy/R
yIgxzrBSzlXio/hnqb0zP2xOkq991keIttFmu6wPDXjqTl9HaeGkliJI0TbV0h44
9e84idVdlHuxF3kbdws7j99TFiTYzc3C9bC1ma/OFpDUbfV9fRrGTnj4NurRmkCh
4fcBR7DkGaw1DDtHvLpoCfZlyDymG9sm72iRM8YDZSsWHdU2uXMMrcBEOS1z7qiV
5gQhF0/VjyA/3nWs4Vxt+f2OeYYzo4AJaHum9il0qu1raxgWSMhpu6yiARH5Kf64
wpYbF7I278l1Yz/yIXDV5iNSRUVyvlRq8Qmq7OSoDcNWhduqGfeRyzMSnLXiI4Pm
yjN5jVBQzJ/NJvOAjqFs8OzxVMeyYtYvD4gV/Sy9wBeMCGTXGnU=
=nLMT
-----END PGP SIGNATURE-----

--ivv5fbufhe273ms5--

--===============6561208670344405679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6561208670344405679==--
