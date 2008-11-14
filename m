From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Fri, 14 Nov 2008 11:16:13 -0800
Message-ID: <200811141116.13682.david-b@pacbell.net>
References: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:42180 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754689AbYKNTQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Nov 2008 14:16:20 -0500
In-Reply-To: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

On Friday 14 November 2008, ext-eero.nurkkala@nokia.com wrote:
> The amount of bytes to receive is read from wrong
> place. It is the 6 bits starting from the bit 8 from
> BUFSTAT_REG that indicate this amount. Not the 8 LSB:s.
> Only 6 LSB:s are used for the TX buffer. Also, with
> omap 3430, only the 6 LSB:s are relevant for XDR.

So to summarize:  2430 and 3430 define this register
differently?  Lacking 2430 docs, I can't verify that.

Agreed that 3430 has two 6-bit fields, RXSTAT at 8..13
and TXSTAT at 0..5, so this code is wrong for 3430.

But if the issue is that the 2430 version of the FIFO
support works differently, please say so in the patch
commend and code...

- Dave

