From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [patch-2.6.34-rc2+ 10/11] musb_core: don't call musb_platform_exit()
 twice
Date: Wed, 24 Mar 2010 15:26:09 +0300
Message-ID: <4BAA04E1.8090204@ru.mvista.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com> <1269431279-22438-11-git-send-email-felipe.balbi@nokia.com> <4BAA0122.2060402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42206 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab0CXM0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 08:26:42 -0400
In-Reply-To: <4BAA0122.2060402@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Greg KH <greg@kroah.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello, I wrote:

>> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>> musb_platform_exit() is called twice from musb_init_controller() iff 
>> controller
>> initialization fails. Move the call (and the DevCtl register writes 
>> surrounding
>> it) from musb_free() to musb_remove().
>>
>> Fix misplaced and now incorrect 'goto's in musb_init_controller().
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> ---
>>  drivers/usb/musb/musb_core.c |   17 +++++++----------
>>  1 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 827b813..90ac17b 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>>   
> [...]
>> @@ -2054,6 +2046,8 @@ bad_config:
>>              musb_readb(musb->mregs, MUSB_DEVCTL));
>>  
>>      }
>> +    if (status < 0)
>> +        goto fail2;
>>  
>>      status = musb_init_debugfs(musb);
>>      if (status < 0)
>>   
>
>   Hm, I don't see this call in the current driver -- are you sure 
> you've used the right tree?

  Right, this is atop of the follwing patch from Greg's 2.6.35-rc1 queue:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-musb-add-debugfs-support.patch

   So, the patch wouldn't apply in the Greg's usb.current series... :-/

WBR, Sergei

