From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
Date: Mon, 18 Apr 2011 09:59:15 +0300 (EEST)
Message-ID: <20110418.095915.238185537231006265.Hiroshi.DOYU@nokia.com>
References: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTin=br7Yw39fnhXbLQg-Wgzym1BXJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:27166 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab1DRHGw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 03:06:52 -0400
In-Reply-To: <BANLkTin=br7Yw39fnhXbLQg-Wgzym1BXJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, omar.ramirez@ti.com
Cc: linux@arm.linux.org.uk, dacohen@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 15 Apr 2011 10:49:42 -0500

> Hi Hiroshi,
> 
> On Fri, Mar 25, 2011 at 3:04 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Commit d038aee24dcd5a2a0d8547f5396f67ae9698ac8e
>> "omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag",
>> changes iovmm to receive flags specified by user, however
>> the upper 16 bits of the flags are wiped by iovmm itself.
>>
>> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
>> map its desired "device addresses".
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>>
>> v2:
>> Include missing reference (commit and name) to patch in
>> description.
> 
> If no comments, could you ack this patch?

Tony, please put this in your queue too.
