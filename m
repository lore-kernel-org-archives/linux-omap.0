From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Sat, 22 May 2010 00:51:23 +0300
Message-ID: <AANLkTinr-FOPC7q22l-i-2S3GeEwPSrV3UeTzTKhS2zj@mail.gmail.com>
References: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
	 <20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
	 <AANLkTik_FL2keLD9mdBcg8Rm9n8uYDElg1NdyeT2yy6B@mail.gmail.com>
	 <20100518.225835.116348725.Hiroshi.DOYU@nokia.com>
	 <AANLkTinpqitfuw3vuDhqXaQH6uHal1nbonVaUg1a2ewt@mail.gmail.com>
	 <20100519181348.GE5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56367 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab0EUVv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 17:51:26 -0400
Received: by bwz7 with SMTP id 7so203491bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 14:51:24 -0700 (PDT)
In-Reply-To: <20100519181348.GE5818@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Wed, May 19, 2010 at 9:13 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [100519 02:58]:
>> Russell, Tony: should mailbox_mach, a module that checks for logical
>> devices be always built-in?
>>
>> I think that's the easiest... in my patches I moved the
>> architecture-specific code from mach-omapX/devices.c to
>> mach-omapX/mailbox.c, so both the logical devices and real platform
>> devices are in the same code, and can be built-in.
>>
>> This way, there's no need to rely on services like udev to load
>> mailbox, then mailbox_mach, then bridgedriver. After all, all
>> mailbox_mach is doing is calling functions in mailbox to register the
>> logical devices.
>>
>> Judging from:
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/58555
>>
>> The answer is yes.
>
> Maybe try using the tested good old criteria: What works the best
> for "standard Linux behaviour" out of the box? :)
>
> Anything that registers platform devices should be built in.
> Also anything that's needed to boot the device into a sane operating
> mode should be built in. For example, the DSP should be powered
> down (or idled on some earlier omaps) even if no bridge is being used.

I think both approaches go into a sane operating mode, the difference is that:
a) requires two modules: mailbox_mach, and mailbox, and udev to figure
out that mailbox depends on mailbox_mach
b) one module, no need for udev

Anyway, I sent a rebased patch series with a longer introduction in
the hopes that the issue is better explained.

FWIW there were no conflicts in the rebasing (except on the last patch
which was trivial, and not really important in the series).

-- 
Felipe Contreras
