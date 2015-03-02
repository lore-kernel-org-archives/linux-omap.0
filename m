From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 5/6] drm/tilcdc: Force building of DRM_TILCDC_INIT
Date: Mon, 2 Mar 2015 14:59:52 +0200
Message-ID: <54F45EC8.4080202@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <2f0e612a87ad97ff9a0b512456a2fe0880d99d54.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="asMBVcd9eN067Re5UPjvI7Kqi5jokOxAM"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <2f0e612a87ad97ff9a0b512456a2fe0880d99d54.1424961754.git.jsarha@ti.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

--asMBVcd9eN067Re5UPjvI7Kqi5jokOxAM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/02/15 16:55, Jyri Sarha wrote:
> If I read Documentation/kbuild/makefiles.txt section 3.6 right, this
> patch should not be needed. However, without this patch the objects
> needed for DRM_TILCDC_INIT are not linked, if DRM_TILCDC is built as
> module.

I also think there's something funny either with the documentation or
the kernel build system.

To summarize (Jyri correct me if I'm wrong):

We enter tilcdc directory using "obj-$(CONFIG_DRM_TILCDC)", and
CONFIG_DRM_TILCDC is either y or m. Inside the directory we have the
necessary makefile and code to build the driver as module or built-in.
And this works fine.

But now Jyri added new piece of code to tilcdc directory, which is
always built-in, even if the tilcdc driver itself is a module. So now if
we enter the directory with "obj-m", and inside the tilcdc/Makefile we
do "obj-y +=3D foo.o" line, the result is that foo.o is compiled, but it
is not linked either to the kernel image nor to the tilcdc.ko.

The doc says:

"Kbuild only uses this information to decide that it needs to visit
the directory, it is the Makefile in the subdirectory that
specifies what is modular and what is built-in."

which doesn't seem to work for us.

> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/gpu/drm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c239b9..62c6158 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_DRM_RCAR_DU) +=3D rcar-du/
>  obj-$(CONFIG_DRM_SHMOBILE) +=3Dshmobile/
>  obj-$(CONFIG_DRM_OMAP)	+=3D omapdrm/
>  obj-$(CONFIG_DRM_TILCDC)	+=3D tilcdc/
> +obj-$(CONFIG_DRM_TILCDC_INIT)	+=3D tilcdc/
>  obj-$(CONFIG_DRM_QXL) +=3D qxl/
>  obj-$(CONFIG_DRM_BOCHS) +=3D bochs/
>  obj-$(CONFIG_DRM_MSM) +=3D msm/

I don't think the above is right. You add two rules for tilcdc
directory. I presume you meant to replace the current tilcdc line with
the new one?

But I don't think the new line makes sense. Using
obj-$(CONFIG_DRM_TILCDC) above makes sense, and also obj-y makes sense,
but obj-$(CONFIG_DRM_TILCDC_INIT) doesn't.

So I think it should be just obj-y, if obj-$(CONFIG_DRM_TILCDC) does not
work.

 Tomi



--asMBVcd9eN067Re5UPjvI7Kqi5jokOxAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9F7IAAoJEPo9qoy8lh71NngP/0CsyvlUrIdh+qv04D/Tt/qC
qssWL32MeJLa+2WD4M7r+R9CmeX+ncyTpMIIqA9gb1RgnOf5Vb+AGuHbKOklcIus
r2vqYDkEkTp1w/EOg1UofWDcpkBJduZkddkNes1pMWbHp113pl//bM9cOViJzxkS
zQFTW5YefidFxzHLMkgpjEkKLLbDix3QAqLGyEE5X7IEj9QC3Ikscf8W4vBKe3OB
H3gpYNQ5dnh/Lhq2qGGz7wKPgzJXlHitmzbSBKP+9ytrOpuZv+1zhjgz0UOlwTTb
lVOJRZ2w+SskFydMaDrsqH9R7w7+G8EMcCeZjsPEwaw8N7kIuwzV5aWt3179YDle
20iyyM3uBdoxSl6gyvdQWt1J7LYzdt9W1JZ1TBXf2lx2MnZgzY4L/6jgn9pLXNjx
65d4ZYcH4k++qz5bGwz71OThvuBOF7HaSzHx4lH+KrxZNs75TNHlQNxdjpku9XS7
dR73tIiUh380Ga8AhIxWIB2GQbE0QncZ4ADi3nsuw51eoBfXjK9FlKTOBq5SQxEA
dM5xKySyHYF0SKsHR5gTpdSOKJmz3Or8Dk/pG5cLGLTgPIwmuz9nRjQ3zn0YBppx
llqSZ4n+XQ5ZLxY7nfjGGZeAGQQXiLiN99ElDT/G4yK6xNDTfAHEsayZfmFxeBV/
eH6pkRSMo8oB/ANI2j/D
=4SMJ
-----END PGP SIGNATURE-----

--asMBVcd9eN067Re5UPjvI7Kqi5jokOxAM--
