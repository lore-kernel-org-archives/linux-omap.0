From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] [OMAP3_PM] Fix zoom2/zoom3 build error
Date: Mon, 16 Nov 2009 09:31:23 -0800
Message-ID: <87ocn2l6l0.fsf@deeprootsystems.com>
References: <20091116144652.GA31051@DFL-61> <4B016725.3030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:38012 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZKPRbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 12:31:20 -0500
Received: by pzk1 with SMTP id 1so2929056pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 09:31:25 -0800 (PST)
In-Reply-To: <4B016725.3030007@ti.com> (Nishanth Menon's message of "Mon\, 16 Nov 2009 08\:52\:21 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Manjunatha GK <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Manjunatha GK had written, on 11/16/2009 08:46 AM, the following:
> Thanks.
>>Re: [PATCH v3] [OMAP3_PM] Fix zoom2/zoom3 build error
> please rename subject to:
> [PATCH V3] OMAP3: PM: Fix build failure with !DEBUG_FS
>
> this is not zoom2/zoom3 specific - am I right?
>
>> The Zoom2 and Zoom3 build breaks on linux-omap-pm(HEAD:pm)
>> when CONFIG_DEBUG_FS is not enabled. 
>>
>> Build error log:
>> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
>> arch/arm/mach-omap2/pm34xx.c:449: undefined reference to `pm_dbg_regset_save'
>> arch/arm/mach-omap2/pm34xx.c:460: undefined reference to `pm_dbg_regset_save'
>> arch/arm/mach-omap2/built-in.o: In function `configure_vc':
>> arch/arm/mach-omap2/pm34xx.c:1237: undefined reference to `pm_dbg_regset_init'
>> arch/arm/mach-omap2/pm34xx.c:1238: undefined reference to `pm_dbg_regset_init'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> This patch fixes the above errors.
> you could state "provide entries for the same when the DEBUG_FS is
> undefined"
>

I agree with Nishanth's comments.

Since these are minor, I'll do cleanups to subject and changelog and
push this to the PM branch.

Thanks,

Kevin
