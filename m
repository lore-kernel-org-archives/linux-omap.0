From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Resend TWl4030 MADC driver
Date: Fri, 11 Apr 2008 12:28:51 -0700
Message-ID: <20080411192851.GI7717@atomide.com>
References: <1207569316-7053-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:58183 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652AbYDKT2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:28:53 -0400
Content-Disposition: inline
In-Reply-To: <1207569316-7053-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080407 04:58]:
> Updated help text on Kconfig clarifying that MADC stands to
> Monitoring Analog-Digital Converter.

Pushing today.

Tony


> Mikko Ylinen (2):
>   I2C: TWL4030: Introduce twl4030 madc driver
>   I2C: TWL4030: Kconfig and Makefile changes
> 
>  drivers/i2c/chips/Kconfig        |   21 ++
>  drivers/i2c/chips/Makefile       |    1 +
>  drivers/i2c/chips/twl4030-madc.c |  453 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl4030-madc.h |  134 +++++++++++
>  4 files changed, 609 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/twl4030-madc.c
>  create mode 100644 include/linux/i2c/twl4030-madc.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
