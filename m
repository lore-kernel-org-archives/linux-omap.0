From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Tue, 5 Jan 2010 12:56:04 +0200
Message-ID: <20100105105604.GE11291@nokia.com>
References: <1262681372-7602-1-git-send-email-x0082077@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22055 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0AEK6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 05:58:47 -0500
Content-Disposition: inline
In-Reply-To: <1262681372-7602-1-git-send-email-x0082077@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Maulik Mankad <x0082077@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

On Tue, Jan 05, 2010 at 09:49:32AM +0100, ext Maulik Mankad wrote:
>ARM : OMAP : Remove #ifdef from board-omap3evm.c
>
>Remove #ifdef around usb_nop_xceiv_register() from
>board-omap3evm.c
>
>Signed-off-by: Maulik Mankad <x0082077@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Tony, let's wait for Greg's Ack to the previous patch, but if everything 
is Fine, you can take this one on for-next.

-- 
balbi
