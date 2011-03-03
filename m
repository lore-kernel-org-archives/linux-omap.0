From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] OMAP3 and 4 hwmod I2C units only allow 16 bit access
Date: Thu, 3 Mar 2011 21:40:32 +0100
Message-ID: <4D6FFCC0.8000007@ti.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com> <20110303135022.30648.8996.stgit@otae.warmcat.com> <4D6FD2F2.8050701@ti.com> <4D6FD63C.6000102@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53363 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758722Ab1CCUkl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 15:40:41 -0500
In-Reply-To: <4D6FD63C.6000102@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "andy.green@linaro.org" <andy.green@linaro.org>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, paul Walmsley <paul@pwsan.com>

On 3/3/2011 6:56 PM, Andy Green wrote:
> On 03/03/2011 05:42 PM, Somebody in the thread at some point said:
>> On 3/3/2011 2:50 PM, Andy Green wrote:
>
> Hi -
>
> Thanks for the reply.
>
>>> Peter Maydell noticed when running under QEMU he was getting
>>> errors reporting 32-bit access to I2C peripheral unit registers
>>> that are documented to be 8 or 16-bit only[1][2]
>>
>> Well, in that case, it is more a QEMU bug since the HW is working fine
>> with 32 bits access to sysconfig :-)
>
> Actually it's documented in TI documentation, as noted:
>
>   >>  [1] OMAP4430 Technical reference manual section 23.1.6.2
>   >>  [2] OMAP3530 Techincal reference manual section 18.6
>
> With the following warning in a nice big grey box -->
>
> ''CAUTION
> The I2Ci registers are limited to 16 bit and 8 bit data accesses, 32 bit
> data access is not allowed and can corrupt register content.''
>
> So, as a side-issue it can be worth confirming with the author of the
> warning if it still holds or not and letting Qemu guys know if it's not
> actually true what is written in the TI docs about that.

I was able to check for OMAP4, and in fact since the I2C bus is using 
only the 16 LSB of the 32 bits interconnect, doing 32 bits access is 
harmless.

But OMAP2 & 3 were using a different interconnect, so it was probably 
not done like that, hence the big CAUTION in the TRM.

>> In fact that flag was added because 32 bits access to I2C sysconfig was
>> generating bus abort on 2420 only:
>> (2004290f55f03c52e22044a5843928cf0f6cc56a).
>>
>> Since 2430, OMAP3 and OMAP4 are working fine with 32 bits, we were lazy
>> and didn't add that flag.
>
> There is no bus abort.  However if the warning in the documentation is
> true, it'd be better that there was a bus abort.
>
>> Did you check this patch on a real HW? Since this was reported using
>> QEMU only.
>
> I checked my patched code works OK on both IGEP2 (OMAP3) and Panda
> (OMAP4), there's no visible symptom without the patch it's true.

Even if starting from OMAP4 generation we can do 32 bits access, since 
the whole IP is documented with 16 bits registers, it is cleaner to 
prevent hwmod access in 32 bits.
I will still report that to the TRM team in order to avoid unnecessary 
scary notes.

>> Otherwise, I'm fine with that patch, it will not change anything but
>> will improve the consistency across SoC version.
>>
>> BTW, It will be good if you could update the omap_hwmod_2430_data.c file
>> as well.
>
> I left it because I can't test it, but I'll happily do it additionally
> if you can test it on some OMAP2 hardware.

Don't hesitate to do it, and clearly add in the cover-letter that it was 
tested on 3430 and 4430 only.
Someone from TI should be able to test it on 2430.

Thanks,
Benoit
