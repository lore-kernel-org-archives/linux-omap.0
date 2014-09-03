From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: gpmc: Don't complain if wait pin is
 used without r/w monitoring
Date: Wed, 3 Sep 2014 11:34:38 +0300
Message-ID: <5406D29E.3040102@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-6-git-send-email-rogerq@ti.com> <540616A0.9040900@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59617 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141AbaICIel (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2014 04:34:41 -0400
In-Reply-To: <540616A0.9040900@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org

On 09/02/2014 10:12 PM, pekon wrote:
> On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
>> For NAND read & write wait pin monitoring must be kept disabled as the
>> wait pin is only used to indicate NAND device ready status and not to
>> extend each read/write cycle.
>>
> I think this description, does not fit in this patch.

It fits the description because it gives the reason why wait monitoring is optional.

> And is incorrect as explained in previous patch review.

It is correct. I've pointed you to the relevant TRM sections where it is said
that GPMC read/write monitoring must be disabled for NAND case.

cheers,
-roger

> 
> 
>> So don't print a warning if wait pin is specified while read/write
>> monitoring is not in the device tree.
>>
>> Sanity check wait pin number irrespective if read/write monitoring is
>> set or not.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
> But below mentioned checks and clean-up makes sense. So
> apart from first 3 lines of commit log ..
> 
> Reviewed-by: Pekon Gupta <pekon@pek-sem.com>
> 
> 
> with regards, pekon
> 
> ------------------------
> Powered by BigRock.com
> 

