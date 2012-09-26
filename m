From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 00/10] ARM: OMAP: PM usecounting changes
Date: Wed, 26 Sep 2012 09:45:58 +0530
Message-ID: <5062817E.8090300@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>  <506186E9.7070908@ti.com> <1348574001.10702.291.camel@sokoban>  <5061A22B.1030603@ti.com> <1348582676.10702.302.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab2IZEQK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 00:16:10 -0400
In-Reply-To: <1348582676.10702.302.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tuesday 25 September 2012 07:47 PM, Tero Kristo wrote:
> Actually I think I accidentally fixed this problem with the latest rev,
> due to the fact that I am using generic clkdm_clk_enable / disable calls
> from iclk now.
>
> I also just tested this (while fixing the complaint from Russell), and
> it looks like both USB and DSS pwrdms are remaining nicely idle on
> OMAP3.

oh, we are good in that case then. Thanks for the update.
