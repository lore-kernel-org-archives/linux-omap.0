From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 11:55:30 +0000
Message-ID: <4B87B6B2.6010005@csr.com>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:36470 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935641Ab0BZL41 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 06:56:27 -0500
In-Reply-To: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, stern@rowland.harvard.edu, oliver@neukum.org

Ajay Kumar Gupta wrote:
> Current musb host driver does the giveback of completed urb first and
> then start the next request. This is significantly affecting the streaming
> from an USB camera wherein we observe huge delay between the two IN tokens
> from musb host. This is due to the fact that UVC driver is doing decoding
> and further processing in giveback context.
> 
> The patch tries to defer the giveback part to a workqueue and continues
> with the start of new request in completion path.

Suggest allocating a per-urb structure when a new URB is enqueued.  This
structure contains the completion/giveback work item.  This avoids
having to a) allocate memory on completion; b) create a second queue
structure.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
