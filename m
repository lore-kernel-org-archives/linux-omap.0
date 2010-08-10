From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead of
 global
Date: Tue, 10 Aug 2010 18:58:03 +0300 (EEST)
Message-ID: <20100810.185803.71555007.Hiroshi.DOYU@nokia.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
	<AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:38585 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab0HJP6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 11:58:13 -0400
In-Reply-To: <AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com, ohad@wizery.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead of global
Date: Tue, 10 Aug 2010 16:36:42 +0200

> Hi Hiroshi,
> 
> On Mon, Jun 14, 2010 at 7:51 PM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
>> As pointed by Ben Ohand, the variable rq_full flag is a global
>> variable, so if there are multiple mailbox users there will be
>> conflics. Now there is a full flag per mailbox queue.
>>
>> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> 
> It looks like this fix didn't get thru - can you please review and ack/nack ?

Sure.

Fernando, could you rebase this patch against the latest omap/master?
