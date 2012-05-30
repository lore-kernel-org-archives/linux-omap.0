From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
Date: Wed, 30 May 2012 20:21:56 +0530
Message-ID: <CAMQu2gxcP8At5j4UOK3bgX+Q+OunXeTxyXEr6hAhGiwjLs-gJg@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com> <1338375394-16268-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:52742 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754790Ab2E3OwS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 10:52:18 -0400
Received: by qcsu28 with SMTP id u28so3078019qcs.36
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 07:52:16 -0700 (PDT)
In-Reply-To: <1338375394-16268-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
> "ocp2scp_usb_phy_ick" clock node was a fake clock node created
> to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now =
added
> (which can be used to control MODULEMODE) this clock node is removed.
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 11 -----------

Have you patched clock44xx_data.c manually or you have a patch for
the clock_data autogen script to generate it ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
