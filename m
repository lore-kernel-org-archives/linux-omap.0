From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 04/17] OMAP2,3 DSS2 Change driver name to
 omap_display
Date: Mon, 10 Jan 2011 16:55:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101654100.5731@utopia.booyaka.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com> <1294399551-10457-5-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1AJXzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 18:55:19 -0500
In-Reply-To: <1294399551-10457-5-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Change the driver name from omapdss to omap_display as the driver takes care of
> the display devices ie number of panels, type of panels available in the
> platform.  Change the device name in the board files and 2420,2430,3xxx clock
> files from omapdss to omap_display to match the driver name.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

Sumit, your Signed-off-by: is missing on this and some of the other 
patches.  Please add it in if you will be submitting these.

> ---
>  arch/arm/mach-omap2/clock2420_data.c         |    8 ++++----
>  arch/arm/mach-omap2/clock2430_data.c         |    8 ++++----
>  arch/arm/mach-omap2/clock3xxx_data.c         |   14 +++++++-------

The clkdev changes in the above three files are

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
