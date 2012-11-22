From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange
 platform devices for ASoC drivers
Date: Thu, 22 Nov 2012 10:03:59 +0900
Message-ID: <20121122010358.GB4371@opensource.wolfsonmicro.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
 <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com>
 <50AA2D01.5020302@ti.com>
 <20121120011526.GF4483@opensource.wolfsonmicro.com>
 <50AD6FB0.3050808@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2577513332348212933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50AD6FB0.3050808@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org


--===============2577513332348212933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 06:20:00PM -0600, Ricardo Neri wrote:
> On 11/19/2012 07:15 PM, Mark Brown wrote:

> >Yes, this would be more sensible if there's no board specifics involved.

> I think they are truly board-specific. For instance, there could be
> some board that does not have the OMAP HDMI IP wired to an external
> connector. We don't want the drivers to be probed in that case. If
> they are in common code, the devices will be created even if a board
> does not have HDMI output.

That's just a case of having a flag in the platform data for the device
saying "don't use this port" as opposed to having the entire ASoC device
instantiation infrastructure in there which is rather Linux specific.

> Something like this:

> 	sound_hdmi {
> 		compatible = "ti,omap-hdmi-card-audio";
> 		ti,model = "OMAP4HDMI";

> 		ti,hdmi_audio = <&hdmi>;
> 		ti,level_shifter = <&tpd12s015>;
> 	};

> The ASoC machine driver would create the platform device for the
> HDMI codec if the DT has the required nodes.

Why not just make this a property of the main HDMI controller - the
compatible property here looks like it's describing the Linux specifics
not the hardware?

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrXnZAAoJELSic+t+oim9qnUP/2Ggni5pspU3gjhVDz+9FLoX
3iaLbSfqey9T/0vmswksfqkYZCvmtQP6hmTzg8Uy6EWXTLVHS89zfyanhNJEmrLH
nZZLPhsVu+zXN2l6iRtMS5Q7AbYoNCFYE5PK5UKmOVDzmMsRtC7UUYnAH8EIj5SF
73+x4bTA5yVlYhq8eFz9YINSoZjYi/iO3vywNbj7KQYnqVlIj/MgjxafJFY5XqMB
qXgRgNbc7xw1/D8UNlxIhWUYRLvbgpFq8ywEog3BYPqaIq98qIR8n/XRxBCJIKt8
m/rhfj8X3U00WbZldZ0QQtD5wwKwdavSWuF5nQcKrCrCzsecwYoMsHYG8b2TkXed
cHmjiedHc+AUd7vDCEDQ8n78UFt2FQDyjPf51Zykcljcco1C/+M/e1lwO1YS1CPX
2ODTbHwlY4Ggb+4BPPFS9ZjZPw39yozl2UyNFchQ1yPyVfIih1JbN7LO6p9GxLse
0VV6IaCorf9HLLUOADY8MqWf+JHVBT4VAbpc1nXU10tke6tFWR5xrwZPbOHTm6fh
h2Zwn2aZFbUqI3HMG/yvquMRjc74QgPCyXbiiJe+Uzhijs55f1B2gnoT2+dkoB7/
GmKS6fRJ3gijTDnVvrXveJVifZ6pOofUy3R+R1qRjMWfTt0+Zmk+jc1iTRKvtEGt
lonz3fL7A9OU8FipTZmA
=nzaP
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--===============2577513332348212933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2577513332348212933==--
