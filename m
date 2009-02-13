From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Removal of duplicate cbus entry
Date: Fri, 13 Feb 2009 14:24:11 -0800
Message-ID: <20090213222411.GK7562@atomide.com>
References: <20090213092300.1b9a5d38.jarkko.nikula@nokia.com> <1234533645-30120-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60538 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZBMWYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 17:24:15 -0500
Content-Disposition: inline
In-Reply-To: <1234533645-30120-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Ameya Palande <ameya.palande@nokia.com> [090213 06:00]:
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 67de08b..fec4d8e 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -39,7 +39,7 @@ obj-$(CONFIG_FB_INTEL)          += video/intelfb/
>  obj-$(CONFIG_SERIO)		+= input/serio/
>  obj-y				+= serial/
>  obj-$(CONFIG_PARPORT)		+= parport/
> -obj-y				+= base/ block/ misc/ mfd/ net/ media/ cbus/
> +obj-y				+= base/ block/ misc/ mfd/ net/ media/
>  obj-y				+= i2c/
>  obj-y				+= cbus/
>  obj-$(CONFIG_NUBUS)		+= nubus/

Thanks, pushing today.

Tony
