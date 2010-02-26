From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 12:33:44 +0100
Message-ID: <201002261233.46872.laurent.pinchart@ideasonboard.com>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:51320 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935107Ab0BZLcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 06:32:50 -0500
In-Reply-To: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, stern@rowland.harvard.edu, oliver@neukum.org

Hi Ajay,

On Friday 26 February 2010 11:39:06 Ajay Kumar Gupta wrote:
> Current musb host driver does the giveback of completed urb first and
> then start the next request. This is significantly affecting the streaming
> from an USB camera wherein we observe huge delay between the two IN tokens
> from musb host. This is due to the fact that UVC driver is doing decoding
> and further processing in giveback context.

I was thinking about adding a workqueue to the UVC driver for URB processing. 
If you beat my by writing a patch before I find time to do so, I won't 
complain ;-)

-- 
Regards,

Laurent Pinchart
