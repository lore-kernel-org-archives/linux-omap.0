From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/6] cbus: retu: tabify retu initialization
Date: Wed, 16 Feb 2011 21:49:43 +0200
Message-ID: <20110216194943.GC2451@legolas.emea.dhcp.ti.com>
References: <1297885350-3462-1-git-send-email-balbi@ti.com>
 <1297885350-3462-6-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45798 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1BPTts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:49:48 -0500
Received: by mail-ew0-f44.google.com with SMTP id 8so646579ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:49:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297885350-3462-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Wed, Feb 16, 2011 at 09:42:29PM +0200, Felipe Balbi wrote:
> @@ -506,13 +503,13 @@ err0:
>  static int __exit retu_remove(struct platform_device *pdev)
>  {
>  	struct retu		*retu = platform_get_drvdata(pdev);
> -	int			irq;
>  
>  	irq = platform_get_irq(pdev, 0);

this should have been deleted. I compiled this.. oh well, I'm sending
another version of this.

-- 
balbi
