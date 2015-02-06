From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
Date: Fri, 6 Feb 2015 19:32:05 +0100
Message-ID: <20150206183205.GS21418@twins.programming.kicks-ass.net>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
 <20150206141346.GP21418@twins.programming.kicks-ass.net>
 <54D4E64C.7060208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D4E64C.7060208@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 06, 2015 at 06:05:32PM +0200, Peter Ujfalusi wrote:
> Certainly looks much simpler, but it adds quite a bit of data to the
> omap_hwmod struct, and we have a _lot_ of them for omap2plus configuration.
> 
> ls -al vmlinux
> 
> w/o any the lockdep warning fixes:
> 110109168
> 
> With my series applied:
> 110112031 (base + 2863)
> 
> With setting individual lockdep class:
> 110114275 (base + 5107)
> 
> I certainly like the lockdep_set_class() way since it is cleaner, but it adds
> almost double amount of bytes to the kernel.

Yeah, I've never really bothered with data too much, its a debug
feature. So lock_class_key is 8 bytes, and strictly speaking you could
union them over other fields, all we really need is unique addresses, we
don't actually use the storage.
