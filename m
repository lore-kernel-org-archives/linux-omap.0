From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Date: Mon, 12 Nov 2012 15:57:34 +0200
Message-ID: <50A1004E.8000203@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com> <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3FDC3557D04656C0BA93B455"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2KLN5k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 08:57:40 -0500
In-Reply-To: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org

--------------enig3FDC3557D04656C0BA93B455
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-12 15:39, Grazvydas Ignotas wrote:
> Hi,
>=20
> On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> This series changes omapfb to use standard dma_alloc funcs instead of =
omap
>> specific vram allocator. This let's us remove the omap vram allocator,=
 making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downs=
ides:
>>
>> ...
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the=

>> applications will interpret as "there's enough vram".
>=20
> Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?
>=20
>> 4) "vram" kernel parameter to define how much ram to reserve for video=
 use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
>=20
> That's a significant change, you should update Documentation/ .

I've added the following documentation change:

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index a564cee..4484e02 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -285,7 +285,10 @@ FB0 +-- GFX  ---- LCD ---- LCD
 Misc notes
 ----------
=20
-OMAP FB allocates the framebuffer memory using the OMAP VRAM allocator.
+OMAP FB allocates the framebuffer memory using the standard dma allocato=
r. You
+can enable Contiguous Memory Allocator (CONFIG_CMA) to improve the dma
+allocator, and if CMA is enabled, you use "cma=3D" kernel parameter to i=
ncrease
+the global memory area for CMA.
=20
 Using DSI DPLL to generate pixel clock it is possible produce the pixel =
clock
 of 86.5MHz (max possible), and with that you get 1280x1024@57 output fro=
m DVI.
@@ -301,11 +304,6 @@ framebuffer parameters.
 Kernel boot arguments
 ---------------------
=20
-vram=3D<size>[,<physaddr>]
-       - Amount of total VRAM to preallocate and optionally a physical s=
tart
-         memory address. For example, "10M". omapfb allocates memory for=

-         framebuffers from VRAM.
-




--------------enig3FDC3557D04656C0BA93B455
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQoQBOAAoJEPo9qoy8lh712bwP/AjZHqo7PMkCAYiJztEILYGs
/tn5AyfC1E/F5GvWugYh/HYtGlDC+Hy9pX1pwOIYTWYEmULfuKBZGt2ykRsolTHR
4FiaOKW2Cm3k8DLn5BaTQ4bQf/ZYR5FYM3MDX0v2IA3aRRWS8vVn5AFOeCLnjjlW
SRmmz/V5bv0MJsQBRc/TQP6+rbhsIZcIFkD8+SWILKOWdAwxhAVoAqUKqhM3fQX9
cHkuPnTCDT9ZT6+wLU37DqpTvLfXn07W7E7qlayNJ++saCcecAjDw1/IVryNHtKo
JMeUOut83J6/bXdgdOTmd6wd8gMphKuykiw1z7llvKPNcBSWIcVujI0wekN8T5rb
Q/JJ8gOy1v+OMM+p2hOEl6ucpB/JwAZ+onzWwAG330w3kwT/eO+djrjqNAN27LgJ
Sg2z2Gq7rlp7+kaQpWja0oxYeoxdTG9bqVTplB2qPzv5z7k9Rj672J08E6R+PvUb
sle/c/mok8Qs/QA+oF+ezlZAQ0JqpPyphNxHmpUN4RP77OectfACPmy3kK63jPgJ
flkxi1eZN9v0ZtgIALrUcYkBQ/8PbBJoRMz3p/cy+S2hZeuAReAI6Wd1jfoYfBM7
dPhBsKi51VqHNBQd2dtnax1m6jh+68HOho2qj3lbuaX06XNO16ltTk1WOOc7nAec
3UizWchsCBZmnASmygWg
=i4tL
-----END PGP SIGNATURE-----

--------------enig3FDC3557D04656C0BA93B455--
