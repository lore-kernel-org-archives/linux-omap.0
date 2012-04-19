From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY
	register fields"
Date: Thu, 19 Apr 2012 10:31:58 +0100
Message-ID: <20120419093158.GX25053@n2100.arm.linux.org.uk>
References: <1333955479-2675-1-git-send-email-archit@ti.com> <1334736386.1886.8.camel@deskari> <4F8E77BA.3000507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40814 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab2DSJcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 05:32:10 -0400
Content-Disposition: inline
In-Reply-To: <4F8E77BA.3000507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com, b-cousson@ti.com

On Wed, Apr 18, 2012 at 01:43:46PM +0530, Archit Taneja wrote:
> On Wednesday 18 April 2012 01:36 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> On Mon, 2012-04-09 at 12:41 +0530, Archit Taneja wrote:
>>> This reverts commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237.
>>>
>>> The commit above swapped the DSI1_PPID and DSI2_PPID register fields in
>>> CONTROL_DSIPHY to be in sync with the newer public OMAP TRMs(after version V).
>>>
>>> With this commit, contention errors were reported on DSI lanes some OMAP4 SDPs.
>>> After probing the DSI lanes on OMAP4 SDP, it was seen that setting bits in the
>>> DSI2_PPID field was pulling up voltage on DSI1 lanes, and DSI1_PPID field was
>>> pulling up voltage on DSI2 lanes.
>>>
>>> This proves that the current version of OMAP4 TRM is incorrect, swap the
>>> position of register fields according to the older TRM versions as they were
>>> correct.
>>
>> Are we sure the bits are the same for all OMAP4 versions? I'm just
>> wondering why the change was made to TRM...
>
> I've tried on OMAP4430 ES2.1 and OMAP4460 ES1.1. I can try on a couple  
> more revisions.
>
> As far as why the change was made in the TRM, it's a bit hard to find  
> the right people, or get response from them :), I'll give that a try 
> again.
>
> If we do conclude that this revert patch is needed, it might probably be  
> a candidate for the 3.2 and 3.3 stable kernels, just wanted to point  
> that out.

I was just going to ask about this, as I haven't noticed any improvement
in mainline kernels since I reported the original failure...
