From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: miscellaneous PRCM & hwmod patches for 3.6
Date: Thu, 5 Jul 2012 16:51:13 +0530
Message-ID: <CAMQu2gwuXnV7E8-+x9EN0qRF9B2OOgY3KMW-nd0GAqHUwHXkGw@mail.gmail.com>
References: <alpine.DEB.2.00.1207040935070.6760@utopia.booyaka.com> <20120705084002.GU1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36238 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277Ab2GELVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 07:21:35 -0400
Received: by qcro28 with SMTP id o28so4951013qcr.33
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 04:21:33 -0700 (PDT)
In-Reply-To: <20120705084002.GU1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

On Thu, Jul 5, 2012 at 2:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Paul Walmsley <paul@pwsan.com> [120704 08:48]:
>> Hi Tony
>>
>> The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:
>>
>>   Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-f-for-3.6
>>
>> for you to fetch changes up to 8cb8de5d87b75f2ecaa1189079764340ea366c0e:
>>
>>   Merge branches 'hwmod_am335x_support_3.6', 'clkdm_pwrdm_devel_a_3.6' and 'misc_devel_3.6' into omap_devel_f_3.6 (2012-07-04 06:05:51 -0600)
>>
>> ----------------------------------------------------------------
>>
>> Miscellaneous OMAP clock, hwmod, clockdomain, and powerdomain patches
>> for 3.6.  Mostly small infrastructure improvements, and preparation
>> for OMAP5 and AM33xx code.
>>
>> ----------------------------------------------------------------
>
> Thanks applying into cleanup-part2 branch.
>
Looks like the merge has not happened correctly.
I see from the commit log that, you had a merge conflict in omap_hwmod.c
and probably while resolving that the below change got missed.

Tarun Kanti DebBarma (1):
      ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API

So I tried pulling Paul's branch again on "cleanup-part2" at commit 8cb8de5d87
and it got merged without any conflicts.

Do you want to re-merge Paul's series in cleanup-part2 or re-apply the above
patch ?

regards
Santosh
