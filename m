From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [BUG] perf_event: no PMU interrupt on OMAP4 with 3.2.0
 (Pandaboard)
Date: Wed, 11 Jan 2012 06:55:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201110647130.31702@utopia.booyaka.com>
References: <20120106134812.GB5122@quad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59491 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab2AKNzC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 08:55:02 -0500
In-Reply-To: <20120106134812.GB5122@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephane Eranian <eranian@googlemail.com>
Cc: linux-omap@vger.kernel.org, will.deacon@arm.com, ming.lei@canonical.com, b-cousson@ti.com

On Fri, 6 Jan 2012, Stephane Eranian wrote:

> I have attached my 3.2.0 changes to this message. With that, I get 
> perf_event to register PMU interrupts 33 and 34. However, they don't 
> fire when I count therefore the counts are bogus (counters wrap around).

Consider verifying first that register accesses to/from the PMU succeed.  
It sounds like this is the case from what you describe, but that would be 
a good first step in debugging this.

If that works, then I'd suggest reviewing the CTI integration code in the 
patch that you sent.  There are lots of magic numbers in there that need 
to be verified.

Please keep in mind that the PMU/CTI support in the patches that you're 
using is quite hacky.  There are several changes that are needed to that 
code for it to be supported cleanly.

> It would be really nice to have perf_event running out of the box on 
> Pandaboard for 3.3. It would go a long way into making performance 
> monitoring usable on ARM.

Sorry to say that given the rework needed in the OMAP PMU/CTI support, 
it's unlikely that this is going into 3.3.


- Paul
