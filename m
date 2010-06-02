From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [PATCH v3 0/5] OMAP/ASoC: McBSP: FIFO handling related fixes
Date: Wed, 2 Jun 2010 12:05:41 +0300
Message-ID: <201006021205.41455.peter.ujfalusi@nokia.com>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62568 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0FBJGJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 05:06:09 -0400
In-Reply-To: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Hi,

On Tuesday 01 June 2010 14:18:19 Ujfalusi Peter (Nokia-D/Tampere) wrote=
:

=2E.

Liam if you are going to take the series, could you fix the patch names=
?
I can also resend them if it is easier for you.

> ---
> Peter Ujfalusi (5):
>   OMAP: McBSP: Function to query the FIFO size
>   OMAP2: McBSP: Change the way how the FIFO is handled
>   OMAP2: McBSP: Use the port's buffer_size when calculating tx delay

These two are not for OMAP2, but OMAP3
I really don't know how it happened, that I left the OMAP2 there, since=
 I have=20
noticed it in the first RFC series..


>   ASoC: omap-mcbsp: Save, and use wlen for threshold configuration
>   ASoC: omap-mcbsp: Place correct constraints for streams
>=20
>  arch/arm/mach-omap2/mcbsp.c             |   10 ++--
>  arch/arm/plat-omap/include/plat/mcbsp.h |    2 +
>  arch/arm/plat-omap/mcbsp.c              |   51 ++++++++++-----
>  sound/soc/omap/omap-mcbsp.c             |  113
> ++++++++++++++++++++++++------- 4 files changed, 129 insertions(+), 4=
7
> deletions(-)

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
