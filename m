From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Wed, 06 Jul 2011 12:31:44 -0700
Message-ID: <4E14B820.6070202@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45803 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755481Ab1GFTbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 15:31:48 -0400
Received: by mail-yw0-f54.google.com with SMTP id 7so131925ywf.13
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 12:31:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On 7/6/2011 12:19 AM, Paul Walmsley wrote:
> Hi,
>
> On Fri, 1 Jul 2011, Benoit Cousson wrote:
>
>> Here are a bunch of cleanups on almost every PRCM related data files.
>> Some of them are purely code moves, and will look like a lot of
>> noise for nothing, but this is needed if we want to keep the files
>> aligned with generator tool and thus ease the future migration to
>> whatever format (common clock framework + DT).
>
> Thanks.  I'll split these up into smaller topic branches, I think
> that's what Tony wants for this window.
>
> Patches 1-3 and 12 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
>
> Patches 4-8 and 11 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.
>
> Patches 9 and 10 have been split into PRCM changes and clock changes. The
> PRCM changes have been queued for 3.1 at git://git.pwsan.com/linux-2.6 in
> the 'prcm_cleanup_a_3.1' branch.  The clock changes have been queued for
> 3.1 at git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.
>
> Patches 13-15 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'hwmod_cleanup_a_3.1' branch.
>
> Patches 17-18 have been queued for 3.1 at
> git://git.pwsan.com/linux-2.6 in the 'hwmod_dss_fix_3.1' branch.
>
> Patch 16, to me, belongs best with the 4460 support series and so I'll see
> if it makes sense to fit it in there somewhere.

Paul,

Do you want me to base the 4460 support series on one of your branches
and re-post including the above patch?

regards,
Rajendra

>
>
> - Paul

