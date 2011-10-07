From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/4] initialize omap SRAM later on with __arm_ioremap_exec()
Date: Fri, 07 Oct 2011 12:29:42 +0530
Message-ID: <4E8EA35E.6050100@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <4E8C0125.1060300@ti.com> <20111006014219.GH6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47449 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212Ab1JGG7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 02:59:48 -0400
Received: by mail-gy0-f180.google.com with SMTP id 8so4928651gyd.11
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 23:59:47 -0700 (PDT)
In-Reply-To: <20111006014219.GH6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 06 October 2011 07:12 AM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [111004 23:29]:
>>
>> Will look at this series in next couple of days and do some testing.
> 
> Thanks, turns out there were a few issues with early ioremap
> that I fixed. Care to check the L4_IO_ADDRESS changes?
>
They look ok to me.

> It's all pushed now into sram-map-io branch at:
> 
> https://github.com/tmlind/linux/tree/sram-map-io
> 
> It seems it's booting now on all omaps I've tried, so will merge
> it into linux-omap master branch as well for testing.
> 
I have reviewed and tested this series. No problems seen.
As asked on other thread, if you are targeting this one for
3.2, then sram changes would have a small conflict with
OMAP4 errata patch. If it is for 3.3, we should be able to
sort out that conflict easily.

Regards
Santosh
