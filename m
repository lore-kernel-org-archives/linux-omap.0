From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Mon, 2 May 2011 12:38:16 +0300
Message-ID: <20110502093815.GQ2529@legolas.emea.dhcp.ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
 <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:52057 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757045Ab1EBJiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 05:38:21 -0400
Content-Disposition: inline
In-Reply-To: <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com, axel.lin@gmail.com, johnstul@us.ibm.com, mpfj-list@mimc.co.uk

On Thu, Apr 21, 2011 at 07:52:42PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> 
> The gpio of EHCI phy should be 0 instead of 1;
> This fixes the hub enumeration issue in beagle xm board.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>

applied, thanks

-- 
balbi
