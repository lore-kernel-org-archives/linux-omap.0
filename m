From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: mmci-omap regressions
Date: Tue, 20 Jan 2009 10:36:59 +0100
Message-ID: <fb249edb0901200136w1787db58ga6600b878b1e0ec7@mail.gmail.com>
References: <20090112091721.GA11921@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:2139 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbZATJhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2009 04:37:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3036889rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 01:37:00 -0800 (PST)
In-Reply-To: <20090112091721.GA11921@michl.2n.cz>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org

2009/1/12 Ladislav Michl <ladis@linux-mips.org>:
> Last time I used MMC card with linux-2.6.15-omap2 and it worked pretty well on
> my custom 5910 based board. Current git nor linux-2.6.22-omap1 (currently used
> for production) doesn't work at all. Inspecting diff between 2.6.15-omap2 and
> 2.6.22-omap1 showed that
> --- a/drivers/mmc/host/omap.c   2009-01-12 09:32:23.000000000 +0100
> +++ b/drivers/mmc/host/omap.c   2009-01-12 09:46:26.000000000 +0100
> @@ -974,7 +974,7 @@
>         * Writing to the CON register twice seems to do the trick. */
>        for (i = 0; i < 2; i++)
>                OMAP_MMC_WRITE(host, CON, dsor);
> -       if (ios->power_mode == MMC_POWER_ON) {
> +       if (ios->power_mode == MMC_POWER_UP) {
>                /* Send clock cycles, poll completion */
>                OMAP_MMC_WRITE(host, IE, 0);
>                OMAP_MMC_WRITE(host, STAT, 0xffff);
> did the trick.

Just confirming that I had the same issue on Palm T|E (omap15xx) and
used a similar modification to make it work.  This was with 2.6.22 so
very long ago.

Cheers
