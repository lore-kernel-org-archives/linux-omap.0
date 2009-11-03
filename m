From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
Date: Tue, 03 Nov 2009 14:04:53 -0800
Message-ID: <87vdhr8dtm.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CD4D@dbde02.ent.ti.com>
	<87zl9lfytn.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE27FC52@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48137 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbZKCWEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 17:04:50 -0500
Received: by pzk26 with SMTP id 26so4250926pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2009 14:04:55 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE27FC52@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 3 Nov 2009 22\:02\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Thursday, August 27, 2009 1:55 PM
>> To: Reddy, Teerth
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
>> 
>> Hi Teerth,
>> 
>> "Reddy, Teerth" <teerth@ti.com> writes:
>> 
>> > From : Teerth Reddy <teerth@ti.com>
>> >
>> > This patch changes for setting the padconf value for sys_nirq line
>> > which is connected to T2 INTR1.  This will fix the T2 keypad wakeup
>> > issue on OMAP3 SDP.
>> >
>> > Signed-off-by: Teerth Reddy < teerth@ti.com >
>> 
>> Patch looks good, thanks.  I'll pull this into PM branch and queue
>> in my PM fixes queue for next merge window.
>> 
>> I did a minor update by adding a comment in the
>> enable_board_wakeup_source function stating that this is the
>> interrupt pin used for T2.
>> 
>> Kevin
>> 
>
> Teerth, Kevin,
>
> Did you test it with OFF mode enabled?

I tested on SDP, but not on omap3evm since that was the only board
file touched by this patch.

> When I do "echo 1 > /sys/power/enable_off_mode" I don't see resume on the omap3evm.
>
> Schematics for the keypad are/seem to be same for EVM and SDP.

I'm guessing that it's because the patch from Teerth only muxes this
pin for the SDP.  I'm guessing that doing the same omap_cfg_reg in the
OMAP3EVM board file will get this working.

Kevin
