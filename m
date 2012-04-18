From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY
 register fields"
Date: Wed, 18 Apr 2012 13:43:46 +0530
Message-ID: <4F8E77BA.3000507@ti.com>
References: <1333955479-2675-1-git-send-email-archit@ti.com> <1334736386.1886.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab2DRIO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 04:14:27 -0400
In-Reply-To: <1334736386.1886.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com, b-cousson@ti.com

On Wednesday 18 April 2012 01:36 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Mon, 2012-04-09 at 12:41 +0530, Archit Taneja wrote:
>> This reverts commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237.
>>
>> The commit above swapped the DSI1_PPID and DSI2_PPID register fields in
>> CONTROL_DSIPHY to be in sync with the newer public OMAP TRMs(after version V).
>>
>> With this commit, contention errors were reported on DSI lanes some OMAP4 SDPs.
>> After probing the DSI lanes on OMAP4 SDP, it was seen that setting bits in the
>> DSI2_PPID field was pulling up voltage on DSI1 lanes, and DSI1_PPID field was
>> pulling up voltage on DSI2 lanes.
>>
>> This proves that the current version of OMAP4 TRM is incorrect, swap the
>> position of register fields according to the older TRM versions as they were
>> correct.
>
> Are we sure the bits are the same for all OMAP4 versions? I'm just
> wondering why the change was made to TRM...

I've tried on OMAP4430 ES2.1 and OMAP4460 ES1.1. I can try on a couple 
more revisions.

As far as why the change was made in the TRM, it's a bit hard to find 
the right people, or get response from them :), I'll give that a try again.

If we do conclude that this revert patch is needed, it might probably be 
a candidate for the 3.2 and 3.3 stable kernels, just wanted to point 
that out.

Archit

>
>   Tomi
>

