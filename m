From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: move mailbox.h out of plat-omap
 headers
Date: Mon, 29 Oct 2012 10:52:28 -0700
Message-ID: <20121029175228.GD11908@atomide.com>
References: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
 <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org
List-Id: linux-omap@vger.kernel.org

Hi,

> --- /dev/null
> +++ b/include/linux/platform_data/omap_mailbox.h
> @@ -0,0 +1,105 @@

This file should only contain pure platform data needed
by the core omap code to pass to the mailbox driver.

The mailbox API header should be somewhere else,
like include/linux/mailbox/mailbox-omap.h or similar.

But shouldn't this all now be handled by using the
remoteproc framework?

Regards,

Tony
