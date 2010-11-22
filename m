From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 04/11] omap: clock: add clkdev aliases for EHCI clocks
Date: Mon, 22 Nov 2010 12:19:13 +0200
Message-ID: <20101122101913.GO2446@legolas.emea.dhcp.ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44738 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753312Ab0KVKTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 05:19:06 -0500
Content-Disposition: inline
In-Reply-To: <1290364814-4417-5-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

On Mon, Nov 22, 2010 at 12:10:07AM +0530, Anand Gadiyar wrote:
>Add clkdev aliases for the USBHOST and USBTLL clocks on OMAP3 and
>OMAP4, so that the driver can refer to the clocks using a common alias.
>
>This will disappear when the driver is converted to use the hwmod
>database, but until then this patch is needed.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Tony, I need your Ack here too.

-- 
balbi
