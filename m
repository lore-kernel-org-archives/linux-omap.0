From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
Date: Thu, 10 Feb 2011 11:04:41 +0530
Message-ID: <AANLkTimah86Mj37rCMYnuprUfeP1XwmxcNBD9S=8g6_N@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59776 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073Ab1BJFen convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 00:34:43 -0500
Received: by wwi17 with SMTP id 17so953469wwi.12
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 21:34:41 -0800 (PST)
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, lo <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, lak <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 3, 2011 at 12:57 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Mailbox hwmod support for OMAP 2,3,4.
>
> This was tested on OMAP3 (3430, 3630), minor testing
> was made on OMAP4.
>
> No testing on OMAP2 since I don't have the hardware.
>
> Highlights from v5 include the comments received from
> previous version v4[1].
>
> Benoit Cousson (1):
> =A0OMAP4: hwmod data: add mailbox data
>
> Felipe Contreras (2):
> =A0OMAP3: hwmod data: add mailbox data
> =A0OMAP: mailbox: build device using omap_device/omap_hwmod
>
> Omar Ramirez Luna (1):
> =A0OMAP: mailbox: use runtime pm for clk and sysc handling
>
> omar ramirez (1):
> =A0OMAP2: hwmod data: add mailbox data
>
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 98 =
+++++-----------------------
> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 67 =
++-----------------
> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0 74 ++++++++++++++=
+++++++
> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0 73 ++++++++++++++=
+++++++
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 72 ++++++++++++++=
++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 67 ++++++++++++++=
+++++
> =A06 files changed, 308 insertions(+), 143 deletions(-)

Boot tested mainline v2.6.38-rc4 along with this 5 patch series on
Omap 2420,2430 SDPs.

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
