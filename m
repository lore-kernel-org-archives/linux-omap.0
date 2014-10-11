From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Fri, 10 Oct 2014 22:40:43 -0400
Message-ID: <543898AB.7060304@hurleysoftware.com>
References: <20140905213216.GD5001@linux.vnet.ibm.com> <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman> <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:46462 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727AbaJKCk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2014 22:40:56 -0400
In-Reply-To: <54388B81.5020306@mentor.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, josh@joshtriplett.org, Rabin Vincent <rabin@rab.in>, Alan Stern <stern@rowland.harvard.edu>, Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 10/10/2014 09:44 PM, Nathan Lynch wrote:
> On 10/10/2014 11:25 AM, Russell King - ARM Linux wrote:
>>
>> Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
>> it seems that this has been known about for some time.)
> 
> Looking at http://gcc.gnu.org/PR58854 it seems that all 4.8.x for x < 3
> are affected, as well as 4.9.0.
> 
>> We can blacklist these GCC versions quite easily.  We already have GCC
>> 3.3 blacklisted, and it's trivial to add others.  I would want to include
>> some proper details about the bug, just like the other existing entries
>> we already have in asm-offsets.c, where we name the functions that the
>> compiler is known to break where appropriate.
> 
> Before blacklisting anything, it's worth considering that simple version
> checks would break existing pre-4.8.3 compilers that have been patched
> for PR58854.  It looks like Yocto and Buildroot issued releases with
> patched 4.8.2 compilers well before the (fixed) 4.8.3 release.  I think
> the most we can reasonably do without breaking some correctly-behaving
> toolchains is to emit a warning.

Providing a manual switch to override blacklisting is way more sane
than a build warning that no one's looking at.

