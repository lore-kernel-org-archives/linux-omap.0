From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: HSMMC pending fixes
Date: Thu, 11 Sep 2008 09:43:24 +0530
Message-ID: <012101c913c4$bd28b850$LocalHost@wipultra1303>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036217F3A9@dlee02.ent.ti.com> <20080911000506.GX21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52990 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbYIKENm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 00:13:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Jarkko Lavinen" <jarkko.lavinen@nokia.com>; <linux-omap@vger.kernel.org>
Sent: Thursday, September 11, 2008 5:35 AM
Subject: Re: HSMMC pending fixes


>* Woodruff, Richard <r-woodruff2@ti.com> [080818 14:09]:
>> Hi,
>> 
>> > owner@vger.kernel.org] On Behalf Of Jarkko Lavinen
>> 
>> 
>> > 2: Disable smartidle mode while suspending (workaround)
>> 
>> This was the work around we had in internal trees for a long time.
>> 
>> However Madhu C. recently updated this based on an internal investigation.  It is required to reset the command pin to clear the system for sleep.  This allows retention to work.
>> 
>> The non-idle work around when profiled showed it was taking a huge amount of time for the clock re-enable to work.  This actually would noticeably reduce MMC throughput when doing aggressive clock cutting in the driver and increase power usage.
>> 
>> +       } else {
>> +               OMAP_HSMMC_WRITE(host->base, SYSCTL,
>> +                       OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
>> +               while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
>> 
>> If you use a really long time out then perhaps it doesn't matter.  But if you try and be aggressive it will hurt you.
> 
> Pushing all except the workaround. Madhu, can you please send a patch
> for what Richard is describing?
Tony, I have already posted the above fix to L-o. I see that it is merged as well. With this fix, I guess there is no need to disable smart idle mode while suspending. Am I missing any other thing here?

Regards,
Madhu

> 
> Thanks,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>
