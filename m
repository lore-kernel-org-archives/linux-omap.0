From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3 v5] AM35x: Add musb support
Date: Fri, 1 Oct 2010 09:00:37 +0300
Message-ID: <20101001060037.GC2925@legolas.emea.dhcp.ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0JAGAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 02:00:38 -0400
Content-Disposition: inline
In-Reply-To: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

Hi,

On Thu, Sep 30, 2010 at 12:19:07AM -0500, Gupta, Ajay Kumar wrote:
>AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
>It has USB phy built inside the IP itself.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

besides the one small question below:

Acked-by: Felipe Balbi <balbi@ti.com>

(note that I don't have that board to fully test this patch)

>+static struct omap_musb_board_data musb_board_data = {
>+	.interface_type         = MUSB_INTERFACE_ULPI,
>+	.mode                   = MUSB_OTG,
>+	.power                  = 500,

can this board really source 500mA ??

-- 
balbi
