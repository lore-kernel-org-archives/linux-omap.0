From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap-2.6.35 on beagleboard based device hangs after
 booting the kernel
Date: Wed, 4 Aug 2010 08:39:19 +0300
Message-ID: <20100804053916.GC6840@atomide.com>
References: <5C6708A1-224D-49D0-90F8-E037EEE7542A@mac.com>
 <D51DF1EE-C759-411A-AC52-7E3A61797254@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64831 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0HDFiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 01:38:55 -0400
Content-Disposition: inline
In-Reply-To: <D51DF1EE-C759-411A-AC52-7E3A61797254@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

* Elvis Dowson <elvis.dowson@mac.com> [100804 02:43]:
> 
> On Aug 4, 2010, at 1:25 AM, Elvis Dowson wrote:
> 
> > 
> > However, after booting, the system just hangs
> > 
> > 
> > Starting kernel ...
> > 
> > Uncompressing Linux... done, booting the kernel.
> 
> I was using beagleboard_defconfig, which probably was insufficient, I should have used omap3_defconfig.

Hmm, sounds like there's something wrong with beagleboard_defconfig
then. Care to enable CONFIG_DEBUG_LL=y and CONFIG_EARLY_PRINTK=y
and add earlyprintk to kernel cmdline and see if you get any
more info why it hangs?

Tony
