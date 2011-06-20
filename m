From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
Date: Mon, 20 Jun 2011 15:18:19 -0700
Message-ID: <878vsw6tas.fsf@ti.com>
References: <1308256260-15597-1-git-send-email-premi@ti.com>
	<87tybk6wh8.fsf@ti.com> <20110620211655.GN2082@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:58693 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755888Ab1FTWSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jun 2011 18:18:23 -0400
Received: by mail-iw0-f175.google.com with SMTP id 19so4504280iwn.6
        for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 15:18:22 -0700 (PDT)
In-Reply-To: <20110620211655.GN2082@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 20 Jun 2011 22:16:55 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Jun 20, 2011 at 02:09:39PM -0700, Kevin Hilman wrote:
>> Sanjeev Premi <premi@ti.com> writes:
>> 
>> > Fix the section mismatch warning:
>> >
>> >   WARNING: vmlinux.o(.text+0x21118): Section mismatch
>> >   in reference from the function pm_dbg_init() to the
>> >   function .init.text:pwrdms_setup()
>> >   The function pm_dbg_init() references
>> >   the function __init pwrdms_setup().
>> >   This is often because pm_dbg_init lacks a __init
>> >   annotation or the annotation of pwrdms_setup is wrong.
>> >
>> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> > ---
>> >  Applies to current linux-omap master
>> 
>> A previous commit just removed the __init annotation here because of a
>> different conflict with the regset init.   The regset code is now
>> removed in my queue for 3.1, so this patch is fine on top of that
>> series.
>> 
>> Queueing for v3.1 (branch: for_3.1/pm-misc)
>
> Sigh.  Please put some thought into it first and stop applying patches
> without first doing some analysis and test-buliding the thing.  Otherwise
> you're going to be applying patches for ever which add and delete
> these things.
>
> If you make pm_dbg_init() __init, then you also have to make
> pm_dbg_regset_init() __init too.  What about the callers to
> pm_dbg_regset_init() - are these marked __init or not?  If not,
> they too will have to be marked __init, etc.
>
> If that's not possible, then the __init attribute must be deleted
> from pwrdms_setup().

As I mentioned above, the regset code (pm_dbg_regset_*) is being removed
in a pending series I already have queued.

Thus, adding back the __init here is fine.  

It was thought about and test built.

Kevin
