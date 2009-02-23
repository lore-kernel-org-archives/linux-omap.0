From: Josh Karabin <gkarabin@vocollect.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 05/23] usb: host: ehci: use resource
 helpers
Date: Mon, 23 Feb 2009 17:29:38 -0500
Message-ID: <49A32352.1060009@vocollect.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com> <1235415171-17376-2-git-send-email-me@felipebalbi.com> <1235415171-17376-3-git-send-email-me@felipebalbi.com> <1235415171-17376-4-git-send-email-me@felipebalbi.com> <1235415171-17376-5-git-send-email-me@felipebalbi.com> <1235415171-17376-6-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.vocollect.com ([64.212.175.113]:4053 "EHLO
	mx3.vocollect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbZBWW7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 17:59:24 -0500
In-Reply-To: <1235415171-17376-6-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>


Felipe Balbi wrote:
> Don't access pdev->resource[n].start directly, we
> can use the resource helpers for that, makes the
> code more readable.
> 

[...snip...]

>  
> -	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> -		dev_dbg(&pdev->dev, "resource[1] is not IORESOURCE_IRQ\n");
> -		retval = -ENOMEM;
> -	}
> -

Your patch description doesn't explain why you removed this code.  Was it intentional?  I didn't see that any of the helpers called below covered the case, but I didn't look too hard.

Regards,

- Josh


