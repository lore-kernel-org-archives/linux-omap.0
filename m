From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 1/3] omap: voltage: Allow custom vp_init() implementation
Date: Thu, 24 Feb 2011 06:41:27 +0530
Message-ID: <4D65B03F.304@ti.com>
References: <1298483913-20344-1-git-send-email-premi@ti.com> <1298483913-20344-2-git-send-email-premi@ti.com> <AANLkTimWhTdKsuw8fUTx_6=+xVQqS89VR_POBnn-hHOm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024BE49223@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45281 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659Ab1BXBLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 20:11:46 -0500
Received: by mail-wy0-f175.google.com with SMTP id 38so54243wyb.20
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 17:11:41 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BE49223@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote, on 02/24/2011 02:15 AM:
>> -----Original Message-----
>> From: Menon, Nishanth
>> Sent: Thursday, February 24, 2011 12:06 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [RFC 1/3] omap: voltage: Allow custom vp_init()
>> implementation
>>
>> On Wed, Feb 23, 2011 at 23:28, Sanjeev Premi<premi@ti.com>  wrote:
>>> Current implementation expects AVS to be available
>>> on the processor - by default. May not be true.
>>>
>>> This patch allows the vp_init() to be implemented
>>> per processor (or family) - same as vc_init().
>>
>> I believe Voltage Processor != Smart reflex AVS. Smart reflex AVS
>> module talks to VP talks to VC talks over I2C_SR to PMIC.
>> absence of AVS does'nt imply VP,VC dont exist or the potential to hook
>> up a PMIC over I2C_SR. no?
>
> [sp] But their role is limited to AVS only. If there is/was no AVS
>       what would they be doing? Delta value written via SW on I2C would
>       still get TWL working.
I dont think so. with SR, the prominence is higher, but normal voltage 
setting, + additional FSMs hooked to VC, VP make it's existance 
independent of AVS - mebbe this detail is just a technical nuance..
>
>       And if you look into the omap_vdd_info you'd see what I meant.

data structure wise, yeah I think we'd have to evolve a bit, Pauls' 
voltage.c cleanup series is one of the tiny steps we have to take.

do feel free to propose any improvements and we can discuss in the ML.

[..]
-- 
Regards,
Nishanth Menon
