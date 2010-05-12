From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 0/0] McBSP changes for OMAP4 platform
Date: Wed, 12 May 2010 11:39:26 +0300
Message-ID: <201005121139.26990.peter.ujfalusi@nokia.com>
References: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29967 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0ELIjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 04:39:40 -0400
In-Reply-To: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lrg@slimlogic.co.uk, tony@atomide.com, broonie@opensource.wolfsonmicro.com

Hi,

On Thursday 06 May 2010 04:15:44 ext Jorge Eduardo Candelaria wrote:
> The following patches enable McBSP driver to be used along with the
> audio driver in SDP4430 and other OMAP4 based boards.
>=20
> Changes from v1:
> - Changed to correct IRQ lines.
> - Check if rx_irq is defined, instead of checking if cpu is omap4
>=20
> Jorge Eduardo Candelaria (2):
>       ARM: McBSP: Fix request for irq in OMAP4
>       ARM: OMAP4: Add support for omap4 in McBSP driver
>=20
>  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
>  arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++--------------=
-
>  2 files changed, 23 insertions(+), 23 deletions(-)

Looks good with Jarkko's comment.
However, I'd like to ask Tony, Liam, Jarkko, and Mark the following:
Would it make sense to use the alsa tree for OMAP McBSP related patches=
, while=20
keeping l-o in CC off course.
If we have patches for mcbsp pending in l-o and in alsa tree, than we a=
re going=20
to have hard times to sort things out when they need to be merged.

I'm asking this, because I will also have some patches for mcbsp, which=
 will=20
need change in arch/ and in sound/ as well.

I know that taking patches to alsa tree for the arch/ is unorthodox, bu=
t it will=20
ease up our life in a long run...

What do you think?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
