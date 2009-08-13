From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: What does the DSPBRIDGE do?
Date: Thu, 13 Aug 2009 09:30:59 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53041956F38F@dlee03.ent.ti.com>
References: <436C2ED5-B3D9-419D-88C1-9CDE693E8F30@mac.com>
 <4A83C3AD.6000908@nt.tu-darmstadt.de>
 <9B5783D4-1503-4B19-8126-721EA0714BC6@mac.com> <4A83E1AD.5020303@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbZHMObl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:31:41 -0400
In-Reply-To: <4A83E1AD.5020303@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, ext Elvis Dowson <elvis.dowson@mac.com>
Cc: Vladimir Pantelic <pan@nt.tu-darmstadt.de>, Linux OMAP Users <linux-omap@vger.kernel.org>

Hi Elvis,

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ameya
>Palande
>Subject: Re: What does the DSPBRIDGE do?
>
>Hi Elvis,
>
>ext Elvis Dowson wrote:
>> Hi Vladimir,
>>
>> On Aug 13, 2009, at 11:41 AM, Vladimir Pantelic wrote:
>>
>>> Elvis Dowson wrote:
>>>> Hi,
>>>> 	I was wondering what the DSPBRIDGE does?
>>> it allows the arm to load/run code on the dsp
>>
>> And this code would be compiled and linked using the ti dsp compiler?
>> what role will the arm gcc compiler play, when using ti dsp compiler?
>>
>> Are there some examples this?
>>


You can also checkout our portal in omapzoom, if you need a more technical overview about dspbridge you can check out in the Docs section: db_linux_rguide.pdf & db_linux_pguide.pdf

https://www.omapzoom.org/gf/project/omapbridge/wiki/?

Samples to the code are at:

DSP Bridge Userspace gitweb: 
http://dev.omapzoom.org/?p=tidspbridge/userspace-dspbridge.git;a=summary

DSP samples (code running in the dsp, either baseimage or dll): source/samples/dsp

MPU samples (arm side app using bridge to interact with the dsp): source/samples/mpu/src

As mentioned before:

GCC compiler will take care of bridge driver (compiled in the kernel), libbridge.so (API) and samples (in case youe need them). CGT Tools and DSP/BIOS package is used to generate the code which will be running on the dsp side.

You can look here for initial environment setup:
https://www.omapzoom.org/gf/project/omapbridge/wiki/?pagename=Build+userspace+files

>> Best regards,
>>
>> Elvis
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>I guess you need TI compiler only for compiling Codes which run on DSP, rest of
>the stuff can be compiled using arm-gcc.
>
>Cheers,
>Ameya.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

- omar
