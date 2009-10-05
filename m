From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Mon, 5 Oct 2009 13:32:37 -0500
Message-ID: <4ACA3BC5.3060609@ti.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>	<4AC76454.20605@gmail.com> <87ws39yciw.fsf@deeprootsystems.com>	<4ACA33AC.4070704@ti.com> <87fx9xwvvf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57678 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbZJESdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 14:33:15 -0400
In-Reply-To: <87fx9xwvvf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 10/05/2009 01:15 PM, the following:
>>>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
>>>>> +		}
>>>>>   
>>>> here is a theoretical bug:
>>>> 1: GPMC, 1, 2, 3 4 5 configured 6 7 not configured.
>>>> 2. Save and restore 1: save and restore variables which are static will
>>>> contain 1-5 and not 6&7
>>>> 3. next I disable 2,3
>>>> 3. save will save 1,4,5 BUT my variable will contain 1,2,3,4,5 ->
>>>> restore will rename 2,3 (which I did not intend)..
>>> Not sure I follow the problem here.  What do you mean by "rename".
>>> The saved context will have values for 2 and 3, but the is_valid
>>> flag will not be set, so they shouldn't be used.
>> My bad.. s/rename/enable/ for 2,3 ->definitely not something I would
>> like to see.
> 
> I must be missing something here.
> 
> I don't see how the restore will do anything if 2,3 have been disabled
> (by gpmc_cs_free()).  AFAICT, the save hook will have cleared the
> is_valid flag, so the restore will do nothing.
> 
> For clarity, I'm also going to modify this patch to set the is_valid
> flag using gpmc_cs_mem_enabled() which make it more clear that
> it's using the same check as gpmc_cs_[enable|disable]_mem()
Got it. Thanks.

-- 
Regards,
Nishanth Menon
