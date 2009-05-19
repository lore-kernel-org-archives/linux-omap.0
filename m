From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] PM: drop clocks_off_while_idle
Date: Tue, 19 May 2009 15:58:22 -0700
Message-ID: <871vqk66pd.fsf@deeprootsystems.com>
References: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
	<13B9B4C6EF24D648824FF11BE8967162038BED6863@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:15974 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZESW6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 18:58:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so27959wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 15:58:25 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BED6863@dlee02.ent.ti.com> (Richard Woodruff's message of "Tue\, 19 May 2009 17\:40\:46 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

> Kevin,
>
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>
>>   echo 0 > /sys/power/clocks_off_while_idle
>>
>>
>
> For PM branch are you keeping any kind of running readme file for
> inclusion in Documentation directory?  It would be pretty useful to
> capture interface changes.

No. Nothing in-kernel at the moment as this is all work-in-progress
and changing.

However, Vikram and company are mostly done with a Wiki page on
omapzoom.org that documents all the sysfs knobs and other debugging
techniques.

Kevin

