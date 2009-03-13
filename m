From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 18:04:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903121759170.26959@utopia.booyaka.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>  <20090310005222.GE19758@fluff.org.uk>  <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com>
 <alpine.DEB.2.00.0903111803170.26959@utopia.booyaka.com>  <1236839178.6478.40.camel@kauppi-desktop>  <alpine.DEB.2.00.0903120041020.26959@utopia.booyaka.com>  <1236844467.6478.103.camel@kauppi-desktop>  <alpine.DEB.2.00.0903120356230.26959@utopia.booyaka.com>
 <1236857625.6478.163.camel@kauppi-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40220 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZCMAEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 20:04:14 -0400
In-Reply-To: <1236857625.6478.163.camel@kauppi-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

(cc's trimmed to drop Ben, i2c list)

Hello Ari,

On Thu, 12 Mar 2009, Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> On Thu, 2009-03-12 at 10:58 +0100, ext Paul Walmsley wrote:
> > Thanks for the details.  Can you extract the list of spurious IRQ warnings 
> > that you're getting, and post them?  I suspect that, like I2C, many of the 
> > driver ISRs are not reading back the device interrupt status registers 
> > after they clear them.
> 
> Sure,
> 
> Here is "grep -hoa 'write for irq.*' *.log | sort | uniq -c" from the
> most problematic case (step 2 in above process). It should be noted that
> the messages are always in pairs, ie. there are two consecutive messages
> in the logs with only microseconds between them. I have divided the
> counts reported by uniq -c by two in the list below.
> 
> Boot count: 6628
>       1 write for irq 12
>       1 write for irq 25
>       1 write for irq 33
>      10 write for irq 37
>   29532 write for irq 56
>      12 write for irq 67
>       1 write for irq 71
>     281 write for irq 73
>     114 write for irq 83
>     407 write for irq 86
> 
> I have also heard that with other use cases irq 17 and 21 should be in
> the list, too. The single ones from 12,25,33,71 are probably just
> one-offs and should not be taken too seriously, 37/67 are corner cases
> but 73/83/86 are definitely valid measurements.

Would you be willing to test some patches that might resolve most of these 
spurious IRQs?  They are here:

   http://www.pwsan.com/omap/spurious-irq-fix.tar.gz

They at least boot okay on a 3430SDP, but since I don't have a test case 
to reproduce the spurious IRQs, I haven't done any further testing.


Thanks for your help with this -

- Paul
