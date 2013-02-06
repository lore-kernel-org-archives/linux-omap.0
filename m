From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: SoC name and revision unification
Date: Wed, 6 Feb 2013 17:11:44 +0200
Message-ID: <CAB=otbQHmBdDs7crwXLni4sNDFUeM+56eEGhcOKAHjEDpX1R0Q@mail.gmail.com>
References: <1359660284-5225-1-git-send-email-ruslan.bilovol@ti.com>
	<1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
	<20130205235626.GS25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:37557 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab3BFPLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 10:11:45 -0500
In-Reply-To: <20130205235626.GS25185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 6, 2013 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [130131 11:28]:
>> This is a long story where for each new generation of
>> OMAP we used different approaches for creating
>> strings for SoCs names and revisions that this patch
>> fixes. It makes future exporting of this information
>> to SoC infrastructure easier.
>
> Maybe use name soc_name and soc_rev instead and make
Yes agree, will change in next patchset

> cpu_name and cpu_rev local to the functions?
> That would reduce some churn here.
This is used in second patch in this series

>
> Also this does not apply to my omap-for-v3.9/soc
> branch. Care to update this (and possibly the second one)
> against that?
Yes, I will rebase the patches on top of this branch.

>
> Regards,
>
> Tony
