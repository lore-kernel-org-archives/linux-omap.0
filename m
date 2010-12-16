From: Nishanth Menon <nm@ti.com>
Subject: Re: pm-core broken
Date: Thu, 16 Dec 2010 10:08:57 -0600
Message-ID: <4D0A3999.4080705@ti.com>
References: <4D09719E.7080700@ti.com> <4D0978F3.3090704@ti.com> <19F8576C6E063C45BE387C64729E739404BD0DB58F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46489 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756560Ab0LPQJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 11:09:03 -0500
Received: by mail-vw0-f48.google.com with SMTP id 18so1360837vws.21
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 08:09:02 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD0DB58F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hiremath, Vaibhav had written, on 12/15/2010 09:00 PM, the following:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Thursday, December 16, 2010 7:57 AM
>> To: Kevin H; linux-omap@vger.kernel.org
>> Subject: pm-core broken
>>
>> Hi Kevin,
>>
>> Just fyi, I tested pm-core(no patches of mine) against SDP3430(ES3.1)
>> and Beagle Rev C1(ES3.0) (that is the only board I could dig up): both
>> fail - I think basically <3630 is broken atm!.
>>
> [Hiremath, Vaibhav] Nishant,
> 
> I am also seeing similar behavior on OMAP3EVM (AM/DM3730), where it does fail with message "Powerdomain (core_pwrdm) didn't enter target state 0". But somehow I am not seeing issues with DSS power domain, not sure what could be happening.

Really curious now. my results with SDP3630:

http://pastebin.mozilla.org/890302

SUSPEND:OFF test | PASS | OFF: 0->1| RET:0 ->0 (7 sec)
SUSPEND:RET test | PASS | OFF: 1->1| RET:0 ->1 (6 sec)
IDLE:OFF test | PASS | OFF: 1->23| RET:1 ->1 (21 sec)
IDLE:RET test | PASS | OFF: 23->23| RET:1 ->23 (21 sec)

are you on k.org? can you run my script 
http://pastebin.mozilla.org/889933 and provide the results for EVM?
-- 
Regards,
Nishanth Menon
