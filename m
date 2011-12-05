From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv7 3/7] omap3: voltage: fix channel configuration
Date: Mon, 05 Dec 2011 12:23:56 -0800
Message-ID: <87r50iix7n.fsf@ti.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	<1322492005-27741-4-git-send-email-t-kristo@ti.com>
	<87pqg6jzq6.fsf@ti.com> <1323077736.7555.10.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44424 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932256Ab1LEUYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 15:24:00 -0500
Received: by mail-iy0-f180.google.com with SMTP id k25so1696829iah.39
        for <linux-omap@vger.kernel.org>; Mon, 05 Dec 2011 12:23:59 -0800 (PST)
In-Reply-To: <1323077736.7555.10.camel@sokoban> (Tero Kristo's message of
	"Mon, 5 Dec 2011 11:35:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2011-12-02 at 15:55 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
>> > overlap with VDD2 and attempting to modify VDD1 voltage will actually change
>> > VDD2 voltage.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> I've forgotten a bit how this was supposed to work (again), Can you
>> elaborate more on how this fails?
>
> There is a diagram in the OMAP TRM for setting the bits in this
> register, however the racen fix part appears to be needed only for
> omap4. I can drop this part of the fix from the series if you want for
> the next version, alternatively I can split this patch into two.

A separate patch, with a descriptive changelog would be preferred.

> The idea for this part of the fix is anyway that the channel
> configuration is more complex in omap4, we define volt_reg and cmd_reg
> addresses for each omap4_X_pmic, however we only want to enable racen
> bit only if cmd and volt register addresses are the same. 

This part still doesn't make sense to me.

If the volt register address (RA_VOL in OMAP4 terms) and command
register address (RA_CMD) are the same, then RACEN shouldn't matter,
since either way the commands go the same address.   

My understanding of RACEN is that it is only for the case where RA_VOL
and RA_CMD are different, so you can select between them.

The current code assumes that if you pass in command register address
you plan to use it.  If it isn't being used (RACEN == 0) then the PMIC
setup should probably not pass in a separate command register address.

What am I missing (or mis-reading in the TRM) here?

Kevin
