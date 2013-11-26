From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] usb: musb: conditionally save and restore the context
 on suspend
Date: Tue, 26 Nov 2013 11:58:32 +0100
Message-ID: <52947ED8.9090506@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-2-git-send-email-zonque@gmail.com> <52947CEB.3090803@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:62810 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab3KZK6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 05:58:36 -0500
In-Reply-To: <52947CEB.3090803@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/26/2013 11:50 AM, Sergei Shtylyov wrote:
> On 25-11-2013 23:39, Daniel Mack wrote:
> 
>> It appears not all platforms featuring a musb core need to save the musb
>> core registers at suspend time and restore them on resume.
> 
>> The dsps platform does, however. So add a bit in struct
>> musb_hdrc_platform_data to let platforms specify their need of such
>> action being taken.
> 
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> [...]
> 
>> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
>> index eb50525..e5a581c 100644
>> --- a/include/linux/usb/musb.h
>> +++ b/include/linux/usb/musb.h
>> @@ -99,6 +99,9 @@ struct musb_hdrc_platform_data {
>>   	/* MUSB_HOST, MUSB_PERIPHERAL, or MUSB_OTG */
>>   	u8		mode;
>>
>> +	/* should the musb core restore registers after suspend? */
>> +	u8		restore_after_suspend:1;
>> +
> 
>     Better placement seems to be with 'extvbus' field which is also 1-bit -- 
> that would save space in the structure.

That patch is deprecated, as things are now done unconditionally,
without consulting this flag.


Daniel
