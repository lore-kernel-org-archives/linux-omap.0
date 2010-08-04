From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: linux-omap-2.6.35 on beagleboard based device hangs after
 booting the kernel
Date: Wed, 4 Aug 2010 12:15:41 +0300
Message-ID: <20100804121541.efc1740f.jhnikula@gmail.com>
References: <5C6708A1-224D-49D0-90F8-E037EEE7542A@mac.com>
	<D51DF1EE-C759-411A-AC52-7E3A61797254@mac.com>
	<20100804053916.GC6840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59031 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224Ab0HDJOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 05:14:44 -0400
Received: by ewy23 with SMTP id 23so1917883ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 02:14:43 -0700 (PDT)
In-Reply-To: <20100804053916.GC6840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, linux-omap@vger.kernel.org

On Wed, 4 Aug 2010 08:39:19 +0300
Tony Lindgren <tony@atomide.com> wrote:

> > I was using beagleboard_defconfig, which probably was insufficient, I should have used omap3_defconfig.
> 
> Hmm, sounds like there's something wrong with beagleboard_defconfig
> then. Care to enable CONFIG_DEBUG_LL=y and CONFIG_EARLY_PRINTK=y
> and add earlyprintk to kernel cmdline and see if you get any
> more info why it hangs?
> 
I have Beagle C2 with U-boot 2009.01-dirty and both v2.6.35 and l-o head
c287f2c5e0b80a272b9ee2032feef7366dcc1e64 boots ok with
omap3_beagle_defconfig.

Does you custom board have the same machine id than Beagle? You'll see
that also with earlyprintk if machine id from bootloader doesn't match
with board(s) support by the kernel.


-- 
Jarkko
