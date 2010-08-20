From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 6/7] usb: ehci: Introduce
 CONFIG_USB_EHCI_HCD_OMAP3
Date: Fri, 20 Aug 2010 08:41:57 +0300
Message-ID: <20100820054157.GD15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:34119 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0HTFmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 01:42:11 -0400
Content-Disposition: inline
In-Reply-To: <1282175377-2784-7-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Keshava Munegowda <keshava_mgowda@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>

On Thu, Aug 19, 2010 at 01:49:36AM +0200, ext Keshava Munegowda wrote:
>@@ -126,6 +126,14 @@ config USB_EHCI_MXC
> 	---help---
> 	  Variation of ARC USB block used in some Freescale chips.
>
>+config USB_EHCI_HCD_OMAP3

USB_EHCI_HCD_OMAP would be enough as you already have omap3 and omap4 
supported.

-- 
balbi

DefectiveByDesign.org
