From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: OMAP: HDMI: Obtain DMA port from resources
Date: Thu, 15 Nov 2012 08:08:55 +0900
Message-ID: <20121114230848.GA4536@opensource.wolfsonmicro.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
 <1352860249-26348-4-git-send-email-ricardo.neri@ti.com>
 <20121114032712.GQ4415@opensource.wolfsonmicro.com>
 <50A3CFBD.5080903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34798 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932216Ab2KNXJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 18:09:02 -0500
Content-Disposition: inline
In-Reply-To: <50A3CFBD.5080903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 11:07:09AM -0600, Ricardo Neri wrote:
> On 11/13/2012 09:27 PM, Mark Brown wrote:

> >Presumably this needs some other corresponding change in the resource
> >setup to go in simultaneously...

> Yes, the change in the resources setup has been submitted to the
> OMAPDSS HDMI driver and accepted by Tomi [1].

Don't do this.  With a change like this which must be made at the same
time over multiple subsystems it is very important that you send all the
parts of the changes together.  Otherwise there's a risk that one of
them won't get merged and even if they do both get merged you'll break
bisection - it's clear that nobody can be testing this on Tomi's branch.

> >>-	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
> >>-		+ OMAP_HDMI_AUDIO_DMA_PORT;
> >>+	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;

> >...both before and after versions use the resource.

> This change should be present in K3.8.

What is "K3.8"?

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpCRxAAoJELSic+t+oim9xC4P/A7NS4DSgjLIhgpIpvFE3fx2
/NwLtAbGCHtelJfcFF6J0X3NCWU2Q8wQtweQe9LpoN95K9FA3CXWYEo9yMKZ4j2m
B8YblH0+IGZGvxeZ6qUQa24fwL/vSMFjGW6ylWv0zbIP2cKh7Z+TtCnA0s0D8AFq
QizZIG8fwmyApCxLvDKuML4DoeHGU4Io0y9Uv5LTOr9N+djGzT9LoA51JfBKFVPK
FQ8YFenA+d5C5M/7CIwtC3I4MO5pZCXITyz9hkLE5s8zu0gm3tdLKN/EVqSnfdAx
RWeOmsPk2axPAiW0lsC3h8hXHdodBAaLkBd3sUvEm8AM4pukXKUdCeznDLhqhnbE
KBbcta1AF+u/fjK9DewGB98HRc39JHSygEMXVbD36V1Vr3wdxPH7mdQnLcvb8FQq
lf+6iTmsPliQxtoBAbI3XSU/5eJOwPTLQ/4xvGV79dIYY0imOgfHFrEAiOmr95du
PX5f9tvJ5KusN0VHzEXnZxMDWFEanB8PZ0HutJxdGqeAywU5Cf3ReADl1F014GeT
J4ZAcGeyiQjw/JA9vaIgybXa2PwupufimfQUCpmFaUG4IoDdPywKohs9R4bc+IiO
AL3ZSfNLT+vvUIsdUchZEOkVw93yiaM4/u18eV7+MQP8EkCYB9cwsYY772mquDCw
wk9ExVs4ny2U+z2Pzn+E
=pnoB
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
