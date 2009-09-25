From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/12] omap: mailbox: Flush posted write when acking
	mailbox irq
Date: Fri, 25 Sep 2009 08:51:22 -0700
Message-ID: <20090925155121.GU4919@atomide.com>
References: <20090924233027.6065.95725.stgit@localhost> <20090924233920.6065.16789.stgit@localhost> <4ABC6D55.3000108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61140 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbZIYPvW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 11:51:22 -0400
Content-Disposition: inline
In-Reply-To: <4ABC6D55.3000108@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Artem Bityutskiy <dedekind1@gmail.com> [090925 00:15]:
> On 09/25/2009 02:39 AM, Tony Lindgren wrote:
>> From: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>>
>> The only way to flush posted write to L4 bus is to do a read back
>> of the same register right after the write.
>
> Just curious, is it really necessary to read back the _same_ register?
> Would reading back any L4 bus-related register be sufficient?

It seems that reading back any register in the same device will do it.

Tony
