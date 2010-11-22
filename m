From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/11] arm: omap4: add USBHOST and related base
 addresses
Date: Mon, 22 Nov 2010 12:24:46 +0200
Message-ID: <20101122102446.GR2446@legolas.emea.dhcp.ti.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com>
 <1290364814-4417-2-git-send-email-gadiyar@ti.com>
 <1290364814-4417-3-git-send-email-gadiyar@ti.com>
 <1290364814-4417-4-git-send-email-gadiyar@ti.com>
 <1290364814-4417-5-git-send-email-gadiyar@ti.com>
 <1290364814-4417-6-git-send-email-gadiyar@ti.com>
 <1290364814-4417-7-git-send-email-gadiyar@ti.com>
 <1290364814-4417-8-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54173 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753357Ab0KVKaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 05:30:03 -0500
Content-Disposition: inline
In-Reply-To: <1290364814-4417-8-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

On Mon, Nov 22, 2010 at 12:10:10AM +0530, Anand Gadiyar wrote:
>Add base addresses for USBHOST, USBTLL, EHCI and OHCI to
>the header file.
>
>This will disappear when the drivers are converted to use
>the hwmod database, however this patch is needed until then.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Tony, I need an Ack here again :-p

-- 
balbi
