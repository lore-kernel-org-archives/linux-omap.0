From: Nishanth Menon <nm@ti.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Fri, 14 Jan 2011 16:22:16 -0600
Message-ID: <4D30CC98.1090508@ti.com>
References: <20110114194758.GM4957@atomide.com> <20110114223701.11e0f7d1.jhnikula@gmail.com> <20110114205424.GQ4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45089 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752450Ab1ANWWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 17:22:21 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so1331678yxd.6
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 14:22:20 -0800 (PST)
In-Reply-To: <20110114205424.GQ4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

Tony Lindgren wrote, on 01/14/2011 02:54 PM:
> * Jarkko Nikula<jhnikula@gmail.com>  [110114 12:34]:
>> On Fri, 14 Jan 2011 11:47:58 -0800
>> Tony Lindgren<tony@atomide.com>  wrote:
>>
>>> - omap4 panda powers down after boot (watchdog?)
>>>
>>> - omap3 ldp board powers down after boot?
>>>
>> my 2c to Panda power down problem:
>>
>> Nishanth helped me recently to debug why my board does this power down
>> and it seems to be caused by a broken hw. I.e. we were using exactly
>> same bootloader and kernel and only my board was not working.
>
> Hmm, mine was working just fine until about a week ago.
> I did update the bootloader also though. What's the recommended
> x-loader + u-boot combo for panda?

The combination I had used was:
x-loader: http://gitorious.org/x-loader/x-loader
u-boot: http://git.denx.de/?p=u-boot.git;a=summary

The issue on the board potentially could be solder issue and RMA was 
recommended.

-- 
Regards,
Nishanth Menon
