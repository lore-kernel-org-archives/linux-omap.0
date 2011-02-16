From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: ehci-omap: add support for TLL mode on OMAP4
Date: Wed, 16 Feb 2011 12:22:23 +0200
Message-ID: <20110216102222.GP2497@legolas.emea.dhcp.ti.com>
References: <1297851194-26264-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59215 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755241Ab1BPKW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 05:22:27 -0500
Content-Disposition: inline
In-Reply-To: <1297851194-26264-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Wed, Feb 16, 2011 at 03:43:14PM +0530, Anand Gadiyar wrote:
> The EHCI controller in OMAP4 supports a transceiver-less link
> mode (TLL mode), similar to the one in OMAP3. On the OMAP4
> however, there are an additional set of clocks that need
> to be turned on to get this working.
> 
> Request and configure these for each port if that port
> is connected in TLL mode.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

should this be going to next merge window or are you fixing any problem
?

-- 
balbi
