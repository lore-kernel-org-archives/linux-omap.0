From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/4 v4] musb: Add context save and restore support
Date: Thu, 17 Dec 2009 19:00:34 +0200
Message-ID: <20091217170034.GC27262@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-3-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31786 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764932AbZLQREb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 12:04:31 -0500
Content-Disposition: inline
In-Reply-To: <1260883909-26836-3-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>

On Tue, Dec 15, 2009 at 02:31:48PM +0100, ext Ajay Kumar Gupta wrote:
>Adding support for MUSB register save and restore during system
>suspend and resume.
>
>Changes:
>        - Added musb_save/restore_context() functions
>        - Added platform specific musb_platform_save/restore_context()
>          to handle platform specific jobs.
>        - Maintaining BlackFin compatibility by adding read/write
>          functions for registers which are not available in BlackFin
>
>Tested system suspend and resume on OMAP3EVM board.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

for this, I'm waiting you and Arnaud to agree on what you both need.

-- 
balbi
