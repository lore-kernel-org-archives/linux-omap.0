From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: ioremap()/iounmap() problem
Date: Thu, 22 Jan 2009 13:55:13 +0200
Message-ID: <1232625313.19861.26.camel@tubuntu>
References: <1232360583.6481.92.camel@tubuntu>
	 <20090119110116.GA15007@n2100.arm.linux.org.uk>
	 <1232368054.6481.110.camel@tubuntu>
	 <20090119125356.GA17861@n2100.arm.linux.org.uk>
	 <1232372980.6481.182.camel@tubuntu>
	 <20090121192332.GA6469@n2100.arm.linux.org.uk>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64220 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbZAVLzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 06:55:55 -0500
In-Reply-To: <20090121192332.GA6469@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

On Wed, 2009-01-21 at 19:23 +0000, ext Russell King - ARM Linux wrote:
> On Mon, Jan 19, 2009 at 03:49:40PM +0200, Tomi Valkeinen wrote:
> > The original problem remains, it looks to me that iounmap() doesn't free
> > the memory, and thus ioremap will fail after couple of loops.
> > 
> > I get the following error on console:
> > 
> > vmap allocation for size 16781312 failed: use vmalloc=<size> to increase
> > size.
> > 
> > I don't know too much about memory management, but I'll try to dig
> > deeper in to this.
> > 
> > What I don't understand is that in __arm_ioremap_pfn() there's
> > get_vm_area(), and later in the function, in case of error, that area is
> > vunmap()ed. But there's no vunmap() done anywhere else in the code for
> > area sections, so who does free it?
> 
> Yes, the error I pointed out is not the only issue with this code.
> 
> You might consider trying my patch which was sent in this thread to Matt
> Gerassimoff.  And if you see anyone whinging that it won't work for
> whatever reason, please ignore them and just test the patch.  You will
> not be disappointed.

Sorry it took so long to test. The patch indeed works fine, thanks! And
the test loop works also fine even without any schedulings, contrary of
what was speculated. (Not that it matters in real usage).

I'll do some more testing and report if I see any oddities.

 Tomi


