From: "Ashish Bijlani" <ashish.bijlani@gmail.com>
Subject: Re: initial frame buffer console
Date: Wed, 9 Jul 2008 09:39:08 -0500
Message-ID: <ec55b17e0807090739l41194d3dt9147ead04f0661e3@mail.gmail.com>
References: <ec55b17e0807082225n6bbbcc10t2963323164821b90@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E73940324B50892@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:5343 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYGIOjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 10:39:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3582433rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Jul 2008 07:39:09 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E73940324B50892@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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
