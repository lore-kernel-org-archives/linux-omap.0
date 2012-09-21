From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 04/12] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Fri, 21 Sep 2012 00:38:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209210032380.6888@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-5-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1209121946410.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab2IUAir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 20:38:47 -0400
In-Reply-To: <alpine.DEB.2.00.1209121946410.17903@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, balbi@ti.com, sourav.poddar@ti.com, gregkh@linuxfoundation.org
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hi 

On Wed, 12 Sep 2012, Paul Walmsley wrote:

> On Thu, 19 Jul 2012, Tero Kristo wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > OMAP4 has module specific context lost registers which makes it now
> > possible to have module level context loss count, instead of relying
> > on the powerdomain level context count.
> > 
> > Add 2 private hwmod api's to update/clear the hwmod/module specific
> > context lost counters/register.
> 
> This one has been modified to align with the changes on patch 3, and 
> queued for 3.7.

Am sorry to say that I had to drop the code changes from this patch, due 
to the OMAP serial bugs addressed by these two patches:

    http://comments.gmane.org/gmane.linux.ports.arm.omap/84729
    http://www.spinics.net/lists/arm-kernel/msg196034.html

Without those two patches, OMAP4430ES2 Panda crashes after Tero's patches 
are applied, with the same symptom as with the N800 crash.  Applying 
those two patches fixes the problem.

It would be good if you guys could ask Greg to pick up the first patch 
ASAP so we can queue the second one during the early 3.7-rc time frame.


- Paul
