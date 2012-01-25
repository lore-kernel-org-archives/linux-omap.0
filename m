From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
Date: Wed, 25 Jan 2012 11:33:41 +0000
Message-ID: <20120125113341.GB3687@opensource.wolfsonmicro.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
 <20120124130008.GC31839@opensource.wolfsonmicro.com>
 <4F1FBBE5.5080804@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53794 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299Ab2AYLdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 06:33:44 -0500
Content-Disposition: inline
In-Reply-To: <4F1FBBE5.5080804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2012 at 10:23:01AM +0200, Peter Ujfalusi wrote:
> On 01/24/2012 03:00 PM, Mark Brown wrote:
> > On Tue, Jan 24, 2012 at 01:52:27PM +0200, Peter Ujfalusi wrote:

> >> Disable the not connected pins on the board based on the
> >> received platform data.
> >> DO not register the jack function on boards, which does not have
> >> means to detect it (jack is always connected).

> > This should no longer be needed with the auto not connected stuff.

> The auto not connected checks if we have connected something in the card
> domain to the codec's input/output/micbias widgets.
> In the machine driver we start from fully wired configuration, and based
> on the received platform data we mark certain connections not connected.
> The audio nc feature would not work here. It will not mark anything nc
> since the DAPM map is complete.

It'd do the right thing if you changed the code to only register the
board widgets and routes as required - from your reply to Jassi it looks
like you ought to do conditional reigstration anyway as the input paths
move around between board variations.

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPH+elAAoJEBus8iNuMP3d7/AP+wXza3YeLDQEfVIO5G17pZe9
7RDObRQ+MHJz5dU8ovNDqTxhF4RB6jByf3YD7boHxbJTTJ5ROscO26hb7ocbjUif
8OD1sIoeaw9W7+cT3XthxsqOCIAGOd2LPkqghuoek0edQIw7+sFFTJSCSzkvhCeE
o6FkiL73Srzc/b4wvuwzE/GlLU408DcBgMhC/APla0Qblj05Q830RyB8wwG4KMNL
SkcsPGLYos6RV/EI/5xncDhSLyDzei25uTpZNVjyj1ksA0sjwW0Bu82p0JKkBZ86
oW3uMgzlLKkp0sdj983l8jbkIJdtNjbPzCa4kb6EyZN/pFV4DLOjc/ajJkkW4bm0
z+mts8DyohcI6fi9N3s615FksKArzjr/vxN+i1Ln0nCU0+MDqEVsesn/288tgmwD
sWnnTSm2swSL18XSzEINnzz9Pl1QHPxcqiCOZsSAsuVIPrgLG56Kv4Zx/98/eWWQ
FA0paZywUMXYetgg0u/ZsEYYy3EPdpnC1+Vz+UTIm+3FZ2Q0eY5ISOAoK0oEeBvD
e680O2SGQGLRWra6KGjhqgtpd3aSyxBp+XWsqJ11iN0iCH+8cvCpPwuVZt0abuSP
aQ3YyNL883JuKl05p1Xzm0gmzVzSG6uTtXFKarU2AXDX2fCsHhhIB9m9G5AfQlXK
+RpUpl6YwQElwJjVtp4D
=W3b5
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
