From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: am35x: fix compile error when building am35x
Date: Wed, 11 May 2011 12:50:44 +0300
Message-ID: <20110511095042.GQ2505@legolas.emea.dhcp.ti.com>
References: <1304329617-5233-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34950 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607Ab1EKQoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:44:54 -0400
Received: by fxm1 with SMTP id 1so563869fxm.29
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 09:44:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304329617-5233-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi,

On Mon, May 02, 2011 at 12:46:57PM +0300, Felipe Balbi wrote:
> am35x_musb_set_mode() was redefined. Fix it.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

Tony, it would be nice to get this in before merge window.

Can you send this with your next fixes ? If you want, I can
prepare a branch on top of -rc7 for you to pull, just let me
know.

-- 
balbi
