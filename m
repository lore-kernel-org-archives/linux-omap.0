From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 08 Feb 2012 16:11:19 -0800
Message-ID: <87mx8sx3vc.fsf@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	<E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
	<20120208184539.GE29796@atomide.com> <87ty312ae0.fsf@ti.com>
	<20120208235358.GD16877@atomide.com>
	<20120208235716.GE16877@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:32916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757864Ab2BIALV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:11:21 -0500
Received: by pbcwz12 with SMTP id wz12so986048pbc.15
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 16:11:20 -0800 (PST)
In-Reply-To: <20120208235716.GE16877@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Feb 2012 15:57:16 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [120208 15:22]:
>> * Kevin Hilman <khilman@ti.com> [120208 14:35]:
>> > Tony Lindgren <tony@atomide.com> writes:
>> > 
>> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
>> > >> While testing on my OMAP3430 platform, this error message was emitted:
>> > >> 
>> > >> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
>> > >> 
>> > >> Trying to find this message was difficult because it was wrapped across
>> > >> several lines.  It also mis-spells "required", doesn't read very well,
>> > >> and has spaces lacking.  Let's replace it with a more concise:
>> > >> 
>> > >> omap_vc_init_channel: No PMIC info for vdd_core
>> > >> 
>> > >> While we're here, fix a simple spelling error in a comment.
>> > >> 
>> > >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > >
>> > > Acked-by: Tony Lindgren <tony@atomide.com>
>> > 
>> > NAK.
>> > 
>> > Tony, please use the patches already in your cleanup branch (that came
>> > from my for_3.3/cleanup/pm) that fix this and also fix a similar problem
>> > for VP.
>> 
>> Ah OK, there's the VP part there too.
>> 
>> So that would be the following two patches then for me to
>> move to fixes from cleanup:
>> 
>> cd63040e00ea83729673acfea1675d85fde6ea59 ARM: OMAP: voltage: cleanup VC/VP error messages
>> af9a2ed9667b49e7e125eac526d8f655183ce53e ARM: OMAP2+: voltage: add check for missing PMIC info in VP init
>> 
>> And patches 1 and 5 for Russell to drop then.
>> 
>> Everybody OK with that?
>
> Also, what about this one in the cleanup branch:
>
> d269914ece0498f31603ecd85ed3d7a586b3cbcd ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
>
> Should that be a fix too?
> 

Yes.

The AM35xx devices that don't use TWL PMICs have the problem fixed by
this patch.

Looking back, I'm not sure why I called this a cleaup branch when all
the patches are fixes.

Kevin
