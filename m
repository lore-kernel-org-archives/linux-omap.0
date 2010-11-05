From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RFC] usb: musb: fail unaligned DMA transfers on v1.8
 and above
Date: Fri, 5 Nov 2010 14:26:31 +0200
Message-ID: <20101105122631.GA1952@legolas.emea.dhcp.ti.com>
References: <1288502759-18618-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34861 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab0KEM0P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 08:26:15 -0400
Content-Disposition: inline
In-Reply-To: <1288502759-18618-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Mike Frysinger <vapier@gentoo.org>

On Sun, Oct 31, 2010 at 12:25:59AM -0500, Gadiyar, Anand wrote:
>The Inventra DMA engine in version 1.8 and later of the MUSB
>controller cannot handle DMA addresses that are not aligned
>to a 4 byte boundary. It ends up ignoring the last two bits
>programmed in the DMA_ADDR register. This is a deliberate
>design change in the controller and is documented in the
>programming guide.
>
>Earlier versions of the controller could handle these
>accesses just fine.
>
>Fail dma_channel_program if we see an unaligned address when
>using the newer controllers, so that the caller can carry out
>the transfer using PIO mode.
>(Current callers already have this backup path in place).
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Ming Lei <tom.leiming@gmail.com>
>Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
>Cc: Mike Frysinger <vapier@gentoo.org>

please fix comment from Sergei and resend without RFC.

-- 
balbi
