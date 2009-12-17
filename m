From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/4] musb: save dynfifo in musb struct
Date: Thu, 17 Dec 2009 18:59:35 +0200
Message-ID: <20091217165935.GA27262@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32593 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513AbZLQRCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 12:02:25 -0500
Content-Disposition: inline
In-Reply-To: <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Tue, Dec 15, 2009 at 02:31:47PM +0100, ext Ajay Kumar Gupta wrote:
>Save dynamic FIFO read only information for later uses during
>musb_save/restore_context functions.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

applied thanks.

-- 
balbi
