From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Tue, 5 Oct 2010 12:09:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010051157500.13816@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com> <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com> <4CA60F88.4020303@ti.com> <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>  <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010051056540.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34603 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0JESJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 14:09:17 -0400
In-Reply-To: <alpine.DEB.2.00.1010051056540.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Oct 2010, Paul Walmsley wrote:

>                 __raw_writew(v, oh->_mpu_rt_va + reg_offs);
>       28:       16ff3070        uxthne  r3, r0
>       2c:       118130b2        strhne  r3, [r1, r2]
> 
> gcc for some reason decides to zero-extend it first, but that is not your
> bug to fix.

Unlikely anyone cares too much about this, but just to follow up, this 
appears to be caused by using -march=armv6 or -march=armv7-a on the gcc 
command line.  Dropping the -march or using -march=armv5 avoids the uxt.
That's with arm-linux-gcc (Sourcery G++ Lite 2008q3-72) 4.3.2.  Minimal 
case follows.  This appears to be gcc bug 40893:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=40893


- Paul

void foo(unsigned int v)
{
  *(volatile unsigned short *)0xabcdefab = (v);
}

arm-linux-gcc  -O2 -march=armv7-a -c test.c; arm-linux-objdump -DS test.o 
| less


00000000 <foo>:
   0:   e30e3fff        movw    r3, #61439      ; 0xefff
   4:   e34a3bcd        movt    r3, #43981      ; 0xabcd
   8:   e6ff0070        uxth    r0, r0
   c:   e14305b4        strh    r0, [r3, #-84]
  10:   e12fff1e        bx      lr


