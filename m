From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar funcs
Date: Fri, 05 Jun 2009 15:53:48 -0700
Message-ID: <873aae70n7.fsf@deeprootsystems.com>
References: <1244206853-4426-1-git-send-email-rnayak@ti.com>
	<87hbyu72n8.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0906051642370.6425@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:49764 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbZFEWxu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 18:53:50 -0400
Received: by pxi40 with SMTP id 40so271220pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 15:53:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0906051642370.6425@utopia.booyaka.com> (Paul Walmsley's message of "Fri\, 5 Jun 2009 16\:44\:37 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> On Fri, 5 Jun 2009, Kevin Hilman wrote:
>
>> Rajendra Nayak <rnayak@ti.com> writes:
>> 
>> > The pwrdm_enable_hdwr_sar/pwrdm_disable_hdwr_sar do not
>> > actually set/reset the SAVEANDRESTORE bit in the PWSTCTRL
>> > register but modify some other bit instead.
>> > This happens due to the OMAP3430ES2_SAVEANDRESTORE_SHIFT
>> > being defined as (1 << 4) instead of just 4.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> 
>> Thanks, pushing to PM branch.
>> 
>> I'll wait to hear from Kalle if we can revert his previous patch
>> for this.
>
> I think Kalle covered this one already:
>
> http://patchwork.kernel.org/patch/15586/

... but was missing from PM branch.  Remedied now.

But we also have a patch in the PM branch[1] which disables the
USBHOST SAR by removing the HAS_HDWR_SAR flag for the pwrdm.

I'm gessing/hoping that fixing this shift value allows us to
revert that patch and am hoping for some confirmation from 
Kalle.

Kevin

[1]  http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=942fc93ce6b5ec7999f7864f6bb088cc8f308f45
