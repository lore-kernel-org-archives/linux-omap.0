From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: initial frame buffer console
Date: Wed, 9 Jul 2008 21:16:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940324B50AD5@dbde02.ent.ti.com>
References: <ec55b17e0807090739l41194d3dt9147ead04f0661e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:53046 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbYGIPq0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 11:46:26 -0400
In-Reply-To: <ec55b17e0807090739l41194d3dt9147ead04f0661e3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashish Bijlani <ashish.bijlani@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Then you should provide details information about your system/setup/usecase?

Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927
TI IP Ph: 509-9927
http://dbdwss01.india.ti.com/pspproducts/

-----Original Message-----
From: Ashish Bijlani [mailto:ashish.bijlani@gmail.com]
Sent: Wednesday, July 09, 2008 8:09 PM
To: Hiremath, Vaibhav
Cc: linux-omap@vger.kernel.org
Subject: Re: initial frame buffer console

Hi Vaibhav,

Thanks for your response. However, I'm not using Linux. I want to add
basic frame buffer support in the kernel for early boot msgs, so I
want to know what could be easiest mode to support.

Cheers,
Ashish

On Wed, Jul 9, 2008 at 1:11 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> Sometime back I came across such issue, please try if it works for you -
>
> Set your "bootargs" to some garbage value, the logs will get diverted automatically to LCD.
>
> Ho I have tested is -
>
> From u-boot prompt issue
>
> #setenv bootargs <copy complete boot argument again including "bootargs">
> #boot
>
> Ideally you should see console diverted to LCD. Please note that you must set bootargs to some garbage value, else it will not get any logs.
>
> Thanks,
> Vaibhav Hiremath
> Senior Software Engg.
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
> TI IP Ph: 509-9927
> http://dbdwss01.india.ti.com/pspproducts/
>
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ashish Bijlani
> Sent: Wednesday, July 09, 2008 10:56 AM
> To: linux-omap@vger.kernel.org
> Subject: initial frame buffer console
>
> Hi,
>
> I'm working with N810. I couldn't get serial port working and want to
> have initial kernel boot msgs on clcd over fbcon. Can somebody guide
> me how to have initial fbcon for kernel boot messages? I want to
> provide minimal frame buffer support may be using internal 640k sram.
>
> Thanks,
> Ashish
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
