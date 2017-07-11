From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codec: cpcap: new codec
Date: Tue, 11 Jul 2017 11:49:11 +0100
Message-ID: <20170711104911.wmzmt5fjkzghwljz@sirena.org.uk>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
 <20170710175152.2jglyjezvptamreq@sirena.org.uk>
 <20170711051540.GV3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8422302910975721272=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170711051540.GV3730@atomide.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============8422302910975721272==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x5yqljhevb3mrh7m"
Content-Disposition: inline


--x5yqljhevb3mrh7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2017 at 10:15:41PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [170710 10:52]:

> > If this is part of a MFD shouldn't the parent device register it without
> > it needing to be in the DT?

> Having the MFD core part just do devm_of_platform_populate() leaves out
> dependencies between the MFD core and it's child devices.

> There are also a lot of board specific configuration to be done for many
> child devices such as ADC wiring, GPIO pins used, and macro firmware
> usage.

> Not sure what all board specific stuff needs to be configured for this
> driver yet, but it seems at least the macro interrupt wiring needs to
> be configured. I would not be surprised to find GPIOs or ADC being used
> for some connector detection too.

We can use subnodes without compatible strings, that's not a problem,
but having to have compatible strings means we're encoding the way Linux
splits device drivers up into the DT which might not work for other OSs
or even future versions of Linux.  For example with CODEC drivers it's
common to have a good chunk of clock control in there which we might at
some point want to move over to the clock subsystem.

--x5yqljhevb3mrh7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllkrSYACgkQJNaLcl1U
h9B+oggAg7qkWrWF2zXm947SZpquxhPChkVKwO3tCNStbQ38UZ5MhZzifBXRNzQE
msSQXlV+BMfqe1IMiWT6jfIcFy04ziBCaRM2aYjHxmit5Dlta5L0roujS4pq+vaN
zzXsNH3PlGtQyFsbbKsfZirbJRqQPWwM3tjAXrfUmwKGnfvL6DD0hdG0cybSY937
ffWWOvLjz8q6Sn3JKfpwkK8Mj6tpvmxK8Z/q69rQU2P4AJxCoIVaB6XFpEGEDZj3
aJ+mypdij74WVBoy0HCdwOu6bazphzymhQrMdfX0yfe/K726f9nWDIir8YLwN32N
smb3wYjPdRLJ2zWZv/gBCBrNdTuORw==
=cifa
-----END PGP SIGNATURE-----

--x5yqljhevb3mrh7m--

--===============8422302910975721272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8422302910975721272==--
