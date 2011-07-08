From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 3/7] OMAP2+: PM: Initialise sleep_switch to a non-valid value
Date: Fri, 08 Jul 2011 07:19:32 -0700
Message-ID: <87wrfsc0sr.fsf@ti.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
	<1309555626-22608-4-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107071635230.2647@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55693 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833Ab1GHOTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 10:19:37 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so1889751pzk.41
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 07:19:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107071635230.2647@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 7 Jul 2011 16:36:50 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> cc'ing Kevin, since this touches mach-omap2/pm.c - an ack would be great 
> if you have the chance
>
> On Fri, 1 Jul 2011, Benoit Cousson wrote:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>> 
>> sleep_switch which is initialised to 0 in omap_set_pwrdm_state
>> happens to be a valid sleep_switch type (FORCEWAKEUP_SWITCH)
>> which are defined as:
>> 
>>  #define FORCEWAKEUP_SWITCH      0
>>  #define LOWPOWERSTATE_SWITCH    1
>> 
>> This causes the function to wrongly program some clock domains
>> even when the Powerdomain is in ON state.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>


Acked-by: Kevin Hilman <khilman@ti.com>


>
> Thanks, this patch has been queued for 3.1 at 
> git://git.pwsan.com/linux-2.6 in the 'powerdomain_fixes_3.1' branch.
>
>
> - Paul
