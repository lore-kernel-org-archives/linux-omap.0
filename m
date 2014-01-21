From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI audio support
 for TDA998x trough McASP I2S bus
Date: Tue, 21 Jan 2014 19:15:47 +0000
Message-ID: <20140121191547.GX17314@sirena.org.uk>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk>
 <52D67099.1040904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uaG9ayzK+U7S/M3N"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57721 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbaAUTQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 14:16:03 -0500
Content-Disposition: inline
In-Reply-To: <52D67099.1040904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, bcousson@baylibre.com


--uaG9ayzK+U7S/M3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 01:27:21PM +0200, Jyri Sarha wrote:
> On 12/31/2013 03:25 PM, Mark Brown wrote:

> >>support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
> >>The 8 least significant bits are ignored.

> >Where does this constraint come from?

> From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N
> register statically to a value that works only with 4 byte samples.
> According to my tests it is possible to support 3 and 2 byte samples
> too by changing the CTS_N register value, but I am not sure if the
> configuration can be changed on the fly. My data sheet of the nxp
> chip is very vague about the register definitions, but I suppose the
> register configures some clock divider on the chip. HDMI supports
> only upto 24bit audio and the data sheet states that any extraneous
> least significant bits are ignored.

Hrm.  This sounds like it ought to be presenting as an ASoC CODEC
driver.

> >>+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
> >>+				     2, 2);

> >Why not just set all this statically when registering the DAI?

> Because there is no relevant DAI to where to put these limitations.
> I did not want to add yet another dummy codec driver, but decided to
> use the already existing ASoC HDMI codec. By default the driver
> support all audio params supported by HDMI. The limitations are
> coming from NXP chip, the NXP driver, and because the chip is used
> in i2s mode. In other words the limitation is coming from machine
> setup, not from the DAIs.

OK, but it sounds like it's got register configuration as well?  That
really does sound like a device that ought to have a driver...

> No excuse for i initialization, I'll fix that. The casting is just
> to survive with just one kmalloc call instead of separate memory
> blobs for
> struct snd_pcm_hw_constraint_list and referred list of supported
> sample rates. I'll allocate a second blob, if that is easier to
> read.

Yes, please.  Unless it's something where memory is getting tight (eg,
due to be allocated a lot) it's more important that we can read the code
than that we save a few bytes.

--uaG9ayzK+U7S/M3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3sdgAAoJELSic+t+oim93/IQAIH/TzaBdreV5rnxjUD2+8qL
+Omf8kUrM0qLX+ozEssPNGm459QwGWVAF0+z5Od91xeXBiBqIojKZYgcUkoDEPqd
DUxCydBs5S6oH6GhdQ6BgpyQzQQRwk6Stl2tXJr3Rfgw28/N13MqgAbJwHv6pk61
z0syBhoR0xiq+HMXaCDj8sHiO3YBQFYHAmKE/MYp0+qUiaX3fabnhAS+UDDxZi4P
HivdDnkFX5/5dZhl22hH0//TGXlnrfqG/tthMiOQQLjsVp0TWo0VGOAb1ql+hv6z
X5RDP3LWFylqzePpf9iLxVxgTEa/uawNXR8ZlBxta5cGIqzL7s4WgvFdUOgnxlQ7
1AKI1I8pp5ZtpM36jAHaBnkur3830DLVDuEKDbqRCeOqJyRPqQee/gL2fhDQMnx6
oeEqRivZPLu9xsW3rt41UwFOlkfnx0MP5DYwk4o6u16Rv4RKHgk5SxewKawS4ed4
A70azunCCLenAt+J4eyslUUO0h1A0ZWvIP8jnZUr4XNj2pLUFJkaV7Ol7r+pH/r7
jTtRKT9nmEUw/QLyYpyLfiQF9Y7FT6eGUoWx0m78m9DmAGbMSnTO/HJULxnBzvQj
2livoDN1LPvyVj+8DeQ0H5mYRg44XTfHM7/UFWEOGLWQkCq5cxmwKP+aBAZUudr3
21UR63Ksa8n2SkItdHIN
=Tyys
-----END PGP SIGNATURE-----

--uaG9ayzK+U7S/M3N--
