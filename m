From: Felipe Balbi <balbi@ti.com>
Subject: Re: double_buffer_not_ok compile error
Date: Mon, 21 Feb 2011 15:56:13 +0200
Message-ID: <20110221135613.GF23087@legolas.emea.dhcp.ti.com>
References: <4D6261C8.1090605@matrix-vision.de>
 <20110221132438.GD23087@legolas.emea.dhcp.ti.com>
 <4D626E93.3070501@matrix-vision.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39928 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751726Ab1BUN4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:56:18 -0500
Received: by mail-bw0-f50.google.com with SMTP id 2so1020068bwz.23
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 05:56:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D626E93.3070501@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: balbi@ti.com, linux-omap@vger.kernel.org

On Mon, Feb 21, 2011 at 02:54:27PM +0100, Michael Jones wrote:
> Hi Felipe,
> 
> Sorry, thanks.  I tried to avoid getting that reply by searching the
> mailing list to see whether this was already discovered.  I searched for
> "double_buffer_not_ok" and "musb_host" on the mailing list but didn't
> see anything newer than the original patch.
> 
> Where is the correct place to search for such a recent fix?  Where is
> Greg's queue?

Yes, Greg's usb-linux or my gitorious musb branch.

-- 
balbi
