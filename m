From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] USB ehci: replace mach header with plat
Date: Tue, 8 Dec 2009 15:47:50 +0200
Message-ID: <20091208134750.GE24510@nokia.com>
References: <1260274506-8805-1-git-send-email-weber@corscience.de>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19898 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbZLHNsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 08:48:09 -0500
Content-Disposition: inline
In-Reply-To: <1260274506-8805-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Thomas Weber <weber@corscience.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 08, 2009 at 01:15:06PM +0100, ext Thomas Weber wrote:
>Replace the mach/usb.h with plat/usb.h
>
>Patch was already done in commit:
>801db9180010676f97bb3fbd7074291128b7b5fc , but overwritten.
>
>Signed-off-by: Thomas Weber <weber@corscience.de>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Tony, this should probably go into for-next or for-next-vol2.

-- 
balbi
