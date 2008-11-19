From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Wed, 19 Nov 2008 14:12:03 +0200
Message-ID: <1227096723.27458.9.camel@eenurkka-desktop>
References: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com>
	 <200811141116.13682.david-b@pacbell.net>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41049 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYKSMOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 07:14:05 -0500
In-Reply-To: <200811141116.13682.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, 2008-11-14 at 11:16 -0800, ext David Brownell wrote:
> On Friday 14 November 2008, ext-eero.nurkkala@nokia.com wrote:
> > The amount of bytes to receive is read from wrong
> > place. It is the 6 bits starting from the bit 8 from
> > BUFSTAT_REG that indicate this amount. Not the 8 LSB:s.
> > Only 6 LSB:s are used for the TX buffer. Also, with
> > omap 3430, only the 6 LSB:s are relevant for XDR.
> 
> So to summarize:  2430 and 3430 define this register
> differently?  Lacking 2430 docs, I can't verify that.
> 
> Agreed that 3430 has two 6-bit fields, RXSTAT at 8..13
> and TXSTAT at 0..5, so this code is wrong for 3430.
> 
> But if the issue is that the 2430 version of the FIFO
> support works differently, please say so in the patch
> commend and code...
> 
> - Dave
> 

I checked against 2420, and there was no such register avaiable at all.
(no 2430 TRM access)

