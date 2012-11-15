From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from
	resources
Date: Thu, 15 Nov 2012 13:10:17 +0900
Message-ID: <20121115040141.GC7599@opensource.wolfsonmicro.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
 <1352860249-26348-4-git-send-email-ricardo.neri@ti.com>
 <20121114032712.GQ4415@opensource.wolfsonmicro.com>
 <50A3CFBD.5080903@ti.com>
 <20121114230848.GA4536@opensource.wolfsonmicro.com>
 <50A45467.6070404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5838150603039632416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50A45467.6070404@ti.com>
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
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@ti.com, s-guiriec@ti.com
List-Id: linux-omap@vger.kernel.org


--===============5838150603039632416==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 08:33:11PM -0600, Ricardo Neri wrote:
> On 11/14/2012 05:08 PM, Mark Brown wrote:

> >Don't do this.  With a change like this which must be made at the same
> >time over multiple subsystems it is very important that you send all the

> but the changes will hit linux-next at some point and they could be
> tested there, right?

This isn't much fun for anyone doing git bisect, it means the device
will be unusuable for large periods of history.

> Sorry, as changes for the HDMI drivers go to several maintainers, I
> was trying to send the relevant patches to the respective
> maintainers and avoid potential merge/rebase issues.

You need to make sure everyone involved knows what's going on - review
should really turn up the sort of issue I just highlighted.

> Tomi has already taken the DSS changes. Perhaps, if you and Tomi
> agree, Tomi could also take the ASoC and the arch/arm/mach-omap2
> changes. This way all changes come from the same tree.

Yes, we're going to need to do that.  Ideally all the changes would be
squashed into a single commit.

> >>This change should be present in K3.8.

> >What is "K3.8"?

> I meant that Tomi took the DSS changes in [1] on his master branch
> and he should push them upstream when the merge window for kernel
> v3.8 opens.

Do you mean that "K3.8" is "v3.8"?

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpGsbAAoJELSic+t+oim9zk0P/0ZPkQByDQ3Uu5s0sRYsJRJ+
LXPhyQMwQdqyuafInhctHu5HwasUa9sDY+E7I+xi1OG7jISl1h9CuFCI8ObBV9dx
4gntBtOUIUOmN/u8+O9wQGptJQAcqzLOQqTmpCxLlyXvf5msbeBOX8WytGNVnSKX
eNBBwCshBJLcPXI5y+K/qq3/JGdodj9510VIKP4LwLoqrYM8CGDozGC/0N937GcB
Q1S5oEFWcEfUPCyuPy7Bc8GDr7q9AizctZf8r4noKuwExCbjTWQ0olVUV383rABp
ncPoxQnqDNA9wUczQY6GfpP7plrxE5tX9vvaFXxnm11Xz39WiRebZtKe1CMPmT1x
sS+/P57g3yh73A0r4Lsehb2LVFrHXKKTdEWedjVZZoCWkYUWQZoyYmw6nRbir+VU
K8IvmfxQYG25IKv1L/AmEqhQo2QzZUp9dXZ1zFYTRZ48NBLZWIjK+Ow/qZTPukRd
9Oe2ZKH7NFaoDjxm/s22fiAS2t0pSw9VcxtJ+6rnxLuj+qVL2+inUeHbHtrwJxgf
pwPiWua1cqaJST6ROCvfzXyuehpyiBaaxZSF8veXN2D/ySncQmtGNwRPriOcizGn
MwgWyMuzoKh9R3XFsb18MVVJOlvfFlkJcAD/O7EMig4VG1hC8E3LXNohcvJN/1wX
r1Y+oNy4EkGSCwIpEKHH
=7HUQ
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

--===============5838150603039632416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5838150603039632416==--
