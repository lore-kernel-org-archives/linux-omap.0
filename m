From: Nishanth Menon <nm@ti.com>
Subject: Re: pm-core broken
Date: Thu, 16 Dec 2010 14:40:56 -0600
Message-ID: <4D0A7958.3080408@ti.com>
References: <4D09719E.7080700@ti.com> <4D0978F3.3090704@ti.com>	<87wrn9hdxy.fsf@deeprootsystems.com> <4D0A52F0.8060603@ti.com> <87fwtxef3r.fsf@deeprootsystems.com> <4D0A735C.80906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44433 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620Ab0LPUk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 15:40:59 -0500
Received: by mail-vw0-f43.google.com with SMTP id 17so1555507vws.16
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 12:40:59 -0800 (PST)
In-Reply-To: <4D0A735C.80906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon had written, on 12/16/2010 02:15 PM, the following:
> Kevin Hilman had written, on 12/16/2010 12:40 PM, the following:
> [...]
>> Your Beagle u-boot must be leaving something else on besides OTG.  I'm
>> using a relatively recent u-boot
>>     U-Boot 2010.12-rc1 (Nov 16 2010 - 
>> 08:31:35)                                    
>> that I built from source for my Beagle C3 (ES3.0), and suspend/idle test
>> works for me:
>>
>> SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (6 
>> sec)                          SUSPEND:RET test | PASS | OFF: 1->1| 
>> RET:0 ->1 (6 sec)                          IDLE:OFF test | PASS | OFF: 
>> 1->4| RET:1 ->4 (21 sec)                            IDLE:RET test | 
>> PASS | OFF: 4->4| RET:4 ->11 (21 sec)                          
>> Is it still CORE that's not hitting RET for you?
> 
> yeah, I just think I am darned blind! DSS power domain did not reach 
> state on Beagle and am guessing that could be due to the evil bootloader 
> I was using - anyways, hoping once Senthils' hwmod patches make in, it 
> should be fixed as well.. unless someone has a reset of DSS clock patch 
> or something.. similar to OTG. arrgh.. as far as I am concerned, problem 
> known at least! for some reason, latest 201012-rc1|2|master etc 
> u-boot.bin is goofing up on me.. will look at that later on if no one 
> beats me to it.
just to close the loop -> enabling CONFIG_OMAP2_DSS in my .config 
(thanks Kevin for the offline suggestion), at least suspend works for 
OFF and RET states. Idle path some how hangs up - for the moment, I 
guess I will leave it alone unless someone else would like to dig further..

-- 
Regards,
Nishanth Menon
