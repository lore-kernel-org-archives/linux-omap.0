From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] I2C: Call request_irq with IRQF_DISABLED
Date: Thu, 5 Mar 2009 21:35:06 +0200
Message-ID: <20090305193505.GA32746@frodo>
References: <1236261264-16053-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53510 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbZCETfM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 14:35:12 -0500
Content-Disposition: inline
In-Reply-To: <1236261264-16053-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Mar 05, 2009 at 03:54:24PM +0200, Ari Kauppi wrote:
> I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> (and thus LOCKDEP) are disabled.
> 
> Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
> but IRQF_DISABLED is needed for proper behaviour.
> 
> Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>

This driver should be in sync with mainline, the only missing commit is

commit 3487568e15df6e133f5f55779dec614dbeb68a99
Author: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Date:   Tue Nov 25 13:03:46 2008 +0200

    i2c: i2c-omap: Fix BUFSTAT_REG reading
    
    The number of bytes to be received is read from wrong
    place with all OMAPs with highspeed I2C support,
    which involves a FIFO and BUFSTAT_REG. It is the 6
    bits starting from the bit 8 in the BUFSTAT_REG
    that indicate this amount of bytes to be read.
    Moreover, only the 6 LSB:s are relevant for the
    TXSTAT field.
    
    Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

That and this one should be going via linux-i2c mainling list. Could you
send Eero's patch and yours to Jean Delvare (i2c maintainer) ? Please
keep linux-omap in the loop.

That said, this makes sense and avoids that we get interrupts while
handling a previous interrupt.

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi
