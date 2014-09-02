From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: gpmc: Don't complain if wait pin is
 used without r/w monitoring
Date: Wed, 03 Sep 2014 00:42:32 +0530
Message-ID: <540616A0.9040900@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.55]:40360 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754125AbaIBTMk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 15:12:40 -0400
In-Reply-To: <1409666227-20622-6-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
> For NAND read & write wait pin monitoring must be kept disabled as the
> wait pin is only used to indicate NAND device ready status and not to
> extend each read/write cycle.
>
I think this description, does not fit in this patch.
And is incorrect as explained in previous patch review.


> So don't print a warning if wait pin is specified while read/write
> monitoring is not in the device tree.
>
> Sanity check wait pin number irrespective if read/write monitoring is
> set or not.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
But below mentioned checks and clean-up makes sense. So
apart from first 3 lines of commit log ..

Reviewed-by: Pekon Gupta <pekon@pek-sem.com>


with regards, pekon

------------------------
Powered by BigRock.com

