From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP: Keypad: Make keypad_data initdata
Date: Tue, 12 Jul 2011 14:13:54 +0530
Message-ID: <4E1C094A.7000307@ti.com>
References: <1310452306-2246-1-git-send-email-shubhrajyoti@ti.com> <b288e44002208a77adcd0c206d15ecf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:43973 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140Ab1GLIoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 04:44:03 -0400
Received: by yxi13 with SMTP id 13so2621457yxi.26
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 01:44:01 -0700 (PDT)
In-Reply-To: <b288e44002208a77adcd0c206d15ecf5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 12 July 2011 12:09 PM, Vishwanath Sripathy wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Shubhrajyoti D
>> Sent: Tuesday, July 12, 2011 12:02 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Shubhrajyoti D
>> Subject: [PATCH] OMAP: Keypad: Make keypad_data initdata
>>
>> The keypad data is accessed only at init so making it initdata.
>> This removes the section mismatch warning.
>>
>> Reported-by: Kevin Hilman<khilman@ti.com>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> ---
>>   arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
>> omap2/board-4430sdp.c
> Is this issue only for OMAP4 SDP? What about Panda, Beagle, OMAP3 SDP
> boards?
> If it's only for OMAP4, pls correct the subject.
Yes will correct the subject line.
> Vishwa
>> index 47e6ab9..2b28c7e 100644
>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> @@ -195,7 +195,7 @@ static struct omap4_keypad_platform_data
>> sdp4430_keypad_data = {
>>   	.cols			= 8,
>>   };
>>
>> -static struct omap_board_data keypad_data = {
>> +static struct omap_board_data keypad_data __initdata = {
>>   	.id	    = 1,
>>   	.pads	 = keypad_pads,
>>   	.pads_cnt       = ARRAY_SIZE(keypad_pads),
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

