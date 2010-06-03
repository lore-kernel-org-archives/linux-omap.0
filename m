From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 03 Jun 2010 10:14:01 +0200
Message-ID: <1275552841.27810.34984.camel@twins>
References: <Pine.LNX.4.44L0.1005271141410.3239-100000@iolanthe.rowland.org>
	 <alpine.LFD.2.00.1005271751240.3032@localhost.localdomain>
	 <20100603042403.GC20028@linux-sh.org>
	 <AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47362 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab0FCION convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 04:14:13 -0400
In-Reply-To: <AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve Hj?nnev?g <arve@android.com>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>

On Wed, 2010-06-02 at 23:58 -0700, Brian Swetland wrote:
> 
> I haven't poked around too much with how things work in SMP
> environments -- are there per-cpu idle threads? 

Yes, and we recently grew the infrastructure for asymmetric MP in the
processing capacity sense.
