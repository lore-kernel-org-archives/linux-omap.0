From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 01/10] OMAP3: serial:
 Check for zero-based physical addr
Date: Mon, 8 Mar 2010 20:24:43 +0200
Message-ID: <20100308182443.GD6630@gandalf>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
 <1268069332-14082-2-git-send-email-saaguirre@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58587 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0CHSY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:24:28 -0500
Content-Disposition: inline
In-Reply-To: <1268069332-14082-2-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On Mon, Mar 08, 2010 at 11:28:43AM -0600, Sergio Aguirre wrote:
> @@ -727,6 +733,10 @@ void __init omap_serial_init_port(int port)
>  	pdev = &uart->pdev;
>  	dev = &pdev->dev;
>  
> +	/* Don't proceed if there's no clocks available */
> +	if (!uart->ick || !uart->fck)
> +		return;

with that loop getting the clocks I would expect this not to happen. If
it happens, then I would guess it deserves a
BUG_ON(!uart->ick || !uart->fck)

-- 
balbi
