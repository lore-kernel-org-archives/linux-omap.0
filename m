From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 17 Mar 2011 22:13:49 +0100
Message-ID: <4D82798D.5090504@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>	 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>	 <1300258302.1917.32.camel@lappyti>	 <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>	 <4D814C72.9010300@openelec.tv> <1300360287.1909.62.camel@lappyti> <EAF47CD23C76F840A9E7FCE10091EFAB033D1A86F2@dbde02.ent.ti.com> <4D826C33.1090705@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail04.solnet.ch ([212.101.4.138]:50996 "EHLO mail04.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755558Ab1CQVNv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:13:51 -0400
In-Reply-To: <4D826C33.1090705@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 17.03.2011 21:16, schrieb Stephan Raue:
> Am 17.03.2011 17:20, schrieb Janorkar, Mayuresh:
...
>> Is it possible for you to enable low-level debugging and pass 
>> omapfb.debug=1 omapdss.debug=1 in your bootargs?
>> This would show the Framebuffer and DSSDBG prints. We would get an 
>> idea if kernel is getting stuck in DSS/OMAPFB.
>>
>> Let me know if you any help in enabling debug prints.
>>
>> Also one more suggestion/ question, are you seeing a hang if DSS is 
>> not enabled in kernel?
>>
>> -Thanks,
>> Mayuresh
>>
> i have done, there is not more output with enable low level debugging 
> and passing this options... :-(
>
> disabling DSS lets boot the kernel and start initramfs (see: 
> http://paste.pocoo.org/show/355262/)
an update:

compiled with DSS/HDMI support as modules, loading modules with:

   modprobe omapdss
   modprobe omapfb

and doing a

   dmesg

in the init script gives me:

   modprobe: can't load module omapdss 
(kernel/drivers/video/omap2/dss/omapdss.ko): invalid module format
   modprobe: can't load module cfbcopyarea 
(kernel/drivers/video/cfbcopyarea.ko): invalid module format

see: http://paste.pocoo.org/show/355300/ line 254,255,514,515

why? the complete kernel with modules is rebuild from scratch

thanks much

Stephan
