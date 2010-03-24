From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: trying to understand the device model
Date: Wed, 24 Mar 2010 19:42:04 +0200
Message-ID: <20100324174204.GA2511@nokia.com>
References: <24f4a101003240943i7e6699f0ocee92abb5d45c19a@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35741 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462Ab0CXRmk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 13:42:40 -0400
Content-Disposition: inline
In-Reply-To: <24f4a101003240943i7e6699f0ocee92abb5d45c19a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hua Yu Yang <huayu.yang@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 24, 2010 at 05:43:38PM +0100, ext Hua Yu Yang wrote:
>hi
>
>sorry for spam if this is actually just naive.
>
>i'm new to linux kernel driver module and planning to write a small
>driver module for gpio test, here is what confuses me:
>
>1. in the kernel module programming guide from tldp.org, a device is
>registered with system by major and minor numbers but in recent kernel
>source( i'm working with 2.6.28.10 ), the files under

that's not recent at all :-s Could you move to current linux-omap git ?

>Documentation/driver-model/ seem to introduce a whole new set of
>models, also in kernel source, gpiolib and plat-omap/gpio.c seem to
>follow the new models. i'm not sure if the way described in kernel
>module programming guide is still valid for recent kernels.

you should try to use current kernels.

>2. for your information, i want to write a simple driver based on gpio
>interface described in Documentation/gpio.txt and implement a 8-bit
>read function as well as an interrupt handler, sort of using gpios to
>emulate a parallel port. this is just a workaround for lacking access
>to camera interface on IGEPv2 board, so no need to consider
>portability or whatsoever, is there any problem for me to just use
>module_init() and module_exit(), as is shown in the kernel module
>programming guide, instead of going into all those add/remove classes,
>buses, interfaces?

I believe you'll like to look at the platform_driver structures and make 
a driver that claims the gpios you need and sets correct direction/value 
when needed.

-- 
balbi
