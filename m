From: Brian Swetland <swetland@google.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 23:58:37 -0700
Message-ID: <AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271141410.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271751240.3032@localhost.localdomain>
	<20100603042403.GC20028@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:19876 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0FCG6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:58:41 -0400
In-Reply-To: <20100603042403.GC20028@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve Hj?nnev?g <arve@android.com>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Wed, Jun 2, 2010 at 9:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>
> On the other hand, while this isn't that difficult for the UP case it
> does pose more problems for the SMP case. Presently the suspend paths
> (suspend-to-RAM/hibernate/kexec jump) all deal with disabling and
> enabling of non-boot CPUs via CPU hotplug explicitly, which will clear
> them from the online CPU map. We would have to rework the semantics a bit
> if cpuidle were also permitted to opportunistically offline CPUs.

That's definitely something we'd be interested in looking at.  Some
upcoming ARM v7 architecture SMP SoCs we're seeing will support full
independent clock scaling and power gating for the individual cores --
if there's not enough work to keep the 2nd (or nth) cpu busy, there
would be good power savings to be had shutting it down.

I haven't poked around too much with how things work in SMP
environments -- are there per-cpu idle threads?

Brian
