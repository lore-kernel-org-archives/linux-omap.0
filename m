From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Fri, 13 Feb 2015 23:15:19 +0000
Message-ID: <20150213231519.GF8670@n2100.arm.linux.org.uk>
References: <54D9F3C7.5000809@freebox.fr>
 <54DA43F8.9090904@hurleysoftware.com>
 <54DBB531.2030504@hurleysoftware.com>
 <20150211200313.GE2531@atomide.com>
 <54DBBE9E.90104@hurleysoftware.com>
 <54DC6832.3070507@linutronix.de>
 <54DCD584.3010500@hurleysoftware.com>
 <20150212192333.GA18882@linutronix.de>
 <54DD053A.8060905@hurleysoftware.com>
 <20150213185115.GF5482@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39924 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbbBMXPh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 18:15:37 -0500
Content-Disposition: inline
In-Reply-To: <20150213185115.GF5482@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Nicolas Schichan <nschichan@freebox.fr>, Tony Lindgren <tony@atomide.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 13, 2015 at 07:51:16PM +0100, Sebastian Andrzej Siewior wrote:
> Something like this maybe?

My personal feeling is that as 0aa525d11859 was wrong, it should be
reverted and this should be another attempt to fix the problem.  In
other words, there should be two patches, one a revert of the previously
known bad commit and this one having another go at it.

I feel that would be a better approach, since then we don't end up
with this change building on a previously know buggy change.  It
would also make the changes to this solution from the previous,
known-to-work-for-decades code more obvious.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
