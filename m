From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 0/1] Fix OMAP_CHIP_INIT usage
Date: Thu, 23 Apr 2009 13:56:22 +0300
Message-ID: <1240484182.6878.39.camel@ubuntu>
References: <> <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:35250 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbZDWK4X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 06:56:23 -0400
In-Reply-To: <1240479787-16921-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-04-23 at 12:43 +0300, Kalle Jokiniemi wrote:
> Found this chip init problem while debugging a problem with
> usb host getting stuck at active mode when toggling the 

BTW, this usb host problem is not fixed by this chip init patch. I'm
sending a separate patch that completely disables the usb host hardware
save/restore. That fixes the "usb_host active" problem.

- Kalle


> /sys/power/enable_off_mode. The OMAP_CHIP_INIT calls used
> "is ES2.0" macros, while it should be now according to the new
> macro definitions "greater or equal to ES2.0".
> 
> Boot tested on RX51 (smartreflex disabled, as there is that problem vp_init 
> problem)
> 
> Should apply on latest pm branch.
> 
> - Kalle
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

