From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 17 Mar 2011 21:16:51 +0100
Message-ID: <4D826C33.1090705@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>	 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>	 <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv>	 <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv>	 <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv>	 <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com>	 <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv>	 <1300258302.1917.32.camel@lappyti>	 <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>	 <4D814C72.9010300@openelec.tv> <1300360287.1909.62.camel@lappyti> <EAF47CD23C76F840A9E7FCE10091EFAB033D1A86F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail05.solnet.ch ([212.101.4.139]:53758 "EHLO mail05.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab1CQUQz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 16:16:55 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033D1A86F2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 17.03.2011 17:20, schrieb Janorkar, Mayuresh:
> Raue,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Valkeinen, Tomi
>> Sent: Thursday, March 17, 2011 4:41 PM
>> To: Stephan Raue
>> Cc: K, Mythri P; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
>>
>> Hi,
>>
>> On Wed, 2011-03-16 at 18:49 -0500, Stephan Raue wrote:
>>
>>> i tried this test tree with omap2plus_defconfig.
>>>
>>> it seems the kernel crashes and poweroff the board on loading this hdmi
>>> stuff, but dont print any crashlog. is there a way any backtraces will
>>> be printed?
>>> output from serial console: http://paste.pocoo.org/show/354850/
>>> kernel config (omap2plus_defconfig, added squashfs support, added
>>> support to include initramfs in kernel, build omapfb stuff statically
>>> into the kernel): http://paste.pocoo.org/show/354853/
> Is it possible for you to enable low-level debugging and pass omapfb.debug=1 omapdss.debug=1 in your bootargs?
> This would show the Framebuffer and DSSDBG prints. We would get an idea if kernel is getting stuck in DSS/OMAPFB.
>
> Let me know if you any help in enabling debug prints.
>
> Also one more suggestion/ question, are you seeing a hang if DSS is not enabled in kernel?
>
> -Thanks,
> Mayuresh
>
i have done, there is not more output with enable low level debugging 
and passing this options... :-(

disabling DSS lets boot the kernel and start initramfs (see: 
http://paste.pocoo.org/show/355262/)

>> Have the HDMI on your setup worked in any (prebuilt) image? What I'm
>> asking is if you are sure the HDMI HW works on your board?
yes, prebuild ubuntu images based on TI's 2.6.35 kernel with hdmi 
support gives me output on my monitor.
>> Powering off quietly sounds strange. Is your power supply sufficient?
>> Well, I don't think that would explain the first crash you posted...
i have seen the board dont poweroff, i have also added LED support so 
the LED's begins to flash after kernel start. but only for a very short 
time until the kernel crashes. so i was thinking it does a power off, 
but the chips on the board are not cold even after some minutes/hours, 
so the board is powered on. The powersupply is the recommended 
powersupply from digikey, so its ok.
