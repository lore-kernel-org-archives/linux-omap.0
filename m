From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Thu, 22 Nov 2012 15:52:21 +0200
Message-ID: <50AE2E15.2070501@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com> <50A5E801.3000100@ti.com>
 <20121120221456.GO18567@atomide.com>
 <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1717411510321147437=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPFyZi52e+BPLFQoSn_scdru=MP2NeBUNUkHnym8W3t90JW2jA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jello huang <ruifeihuang@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1717411510321147437==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig015F3325D81508E7A0630502"

--------------enig015F3325D81508E7A0630502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2012-11-21 16:22, Jello huang wrote:
> HI Tomi,
> we need  one rank of cma to allocate the memory for driver in kernel
> space .And the default CMA is for allocating memory frome usespace.So
> if we allocate the memory from the
> default CMA zone ,there maybe introduce fragmention to the default CMA
> zone.The kernel space memory donot touch the memory from userspace

Can you elaborate a bit? I didn't understand your point. Are you saying
each kernel driver that uses dma_alloc should have their own CMA zone?
That doesn't make sense...

How do you allocate CMA memory from userspace?

 Tomi



--------------enig015F3325D81508E7A0630502
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQri4VAAoJEPo9qoy8lh71K2cQAKhHyJnxW5FFTEMSCCu1c0n0
OHZ9N2A7bqrr6zHg+XUDak2Jlr8itacE5gKgPdp5P5dSF51Oc4mk+QccO4g5VAnC
5VH/wJQwzwVyOGrFqCuboDh3mk8mqGr8jrw7+aGwr7OLHvngCpskEbRh7JOfXZqP
7+G9ZBK7hwbijyK52Rn8xhdJjplAScPV2JcwglpmdbzYKtltjkT+YUmMc2Ygi9yq
j0UcnI6pNW/1MAupHs48XlJodGMeRvhsbriQjwBgLFlxVXJL9JQ+Ee3rezokNmfe
YkzOr+g3lkvhtDt4JOJ0WRZ/PCWBd1t4gQ3X8yAb9QIU4dPLE8/qbmFp6jNxi2sd
i7KX74YcAJA6I9+4OCvVwyVWaAu4Xsf0QmMLKV0sa6MHEHfx493Etv0zzKejjJfq
5dS2M2XjwmScmSW2g3sFiDmaRVhmYOjyohu89YtJO2FB0moeSv2pnlP/L8vKCYUo
rlXgINkMtMz4uzNVGqAx2SUtI60wVws4g7LOvXKqH7Ts5bV+g/AXMsjrPfed7uy8
tSmB+hVjeHq+1LWb94laKAd+SnIB8b6kV0Fj7be09S62MdMt1IASxJOkmvFnVgzK
QvtJBIdzgEV8hSw7HTbfbQoVGhmiOO30z9VzwtXg/15JOQdvHnCQ0KVTDWjz9dFJ
MuU+aZlNSaH/KsmxTRq2
=hIWw
-----END PGP SIGNATURE-----

--------------enig015F3325D81508E7A0630502--


--===============1717411510321147437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1717411510321147437==--
