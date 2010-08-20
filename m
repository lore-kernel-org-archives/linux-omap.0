From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 3/7] usb: ehci-omap: omap: Add OMAP4 support
Date: Fri, 20 Aug 2010 08:38:44 +0300
Message-ID: <20100820053844.GB15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:63496 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0HTFjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 01:39:03 -0400
Content-Disposition: inline
In-Reply-To: <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Keshava Munegowda <keshava_mgowda@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>

Hi,

On Thu, Aug 19, 2010 at 01:49:33AM +0200, ext Keshava Munegowda wrote:
>@@ -298,7 +327,163 @@ static int omap_start_ehc(struct ehci_hc
> 	}
>
> 	if (cpu_is_omap44xx()) {
>-		/* TODO */

driver should never make use of cpu_is_omap* calls neither machine_is_* 
for that matter. Driver shouldn't care about correct clock names either. 
You need to find a better to handle differences between omap3 and omap4.

-- 
balbi

DefectiveByDesign.org
