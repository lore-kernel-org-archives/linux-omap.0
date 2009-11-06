From: "Weng, Wending" <WWeng@rheinmetall.ca>
Subject: RE: The latest 2.6.32.rc5 is very slow
Date: Fri, 6 Nov 2009 09:54:13 -0500
Message-ID: <54B31811B83D744D90BF0289EB447D460916FCE609@MAIL-MB1.oerlikon.ca>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB41@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.rheinmetall.ca ([207.61.105.111]:30974 "EHLO
	MAIL-ET.oerlikon.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757307AbZKFOyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 09:54:09 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB41@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Premi, Sanjeev'" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Premi, Sanjeev [mailto:premi@ti.com]
>Sent: November 6, 2009 9:18 AM
>To: Weng, Wending; linux-omap@vger.kernel.org
>Subject: RE: The latest 2.6.32.rc5 is very slow



>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Weng, Wending
>> Sent: Friday, November 06, 2009 7:36 PM
>> To: linux-omap@vger.kernel.org
>> Subject: The latest 2.6.32.rc5 is very slow
>>
>> Hi All,
>>
>>         I have an omap3evm based system, it was running PSP
>> 1.0.0., everything works fine. Recently, I upgraded the BSP

>[sp] That would be kernel version 2.6.22-18?

That's correct.

>> to the latest 2.6.32.rc5, it's very much straight forward.
>> However, there is a major performance degradation, the system

>[sp] How are you measuring performance degradation?
My system is a map based application, it responds much slower for all user input, I can feel it.
I did some specific testings, for instance, write a short string to the console, usually, it takes less than 1 us for BSP 1.0.0, but the latest BSP will take 30 us or 60 us, the latency always goes up by 30 us. The display call(printf) is translated into sys_write in kernel, I measure its execution latency, indeed, it's 30 or 60 us, even I add spin_lock_irqsave and spin_lock_irqrestore to make sure it will not be disturbed. It doesn't take so much time to execute sys_write, I suspect it's interrupted by DMA or some bus lock.

>> is almost not usable. Has Anybody experienced similar
>> performance problems? What are potential reasons?
>>
>> Wending Weng
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
