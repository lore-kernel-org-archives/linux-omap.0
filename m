From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 4/4] musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Thu, 17 Dec 2009 18:59:51 +0200
Message-ID: <20091217165951.GB27262@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-3-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-4-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31596 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764865AbZLQRBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 12:01:19 -0500
Content-Disposition: inline
In-Reply-To: <1260883909-26836-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Tue, Dec 15, 2009 at 02:31:49PM +0100, ext Ajay Kumar Gupta wrote:
>Some of the board might use external Vbus power supply on musb
>interface which would require to program ULPI_BUSCONTROL register.
>
>Adding 'extvbus' flag which can be set from such boards which will
>be checked at musb driver files before programming ULPI_BUSCONTROL.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

applied, thanks

-- 
balbi
