From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/8] usb: musb: Change end point selection to use new
 IO access
Date: Tue, 25 Nov 2014 16:02:46 +0100
Message-ID: <54749A16.20204@metafoo.de>
References: <1416855906-13931-1-git-send-email-tony@atomide.com> <1416855906-13931-6-git-send-email-tony@atomide.com> <20141124233835.GB14728@tao> <20141124235241.GH2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1051 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaKYPCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2014 10:02:45 -0500
In-Reply-To: <20141124235241.GH2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Apelete Seketeli <apelete@seketeli.net>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

On 11/25/2014 12:52 AM, Tony Lindgren wrote:
> * Apelete Seketeli <apelete@seketeli.net> [141124 15:40]:
>> Hi Tony,
>>
>> Thanks for the patch.
>>
>> On Mon, Nov-24-2014 at 11:05:03 AM -0800, Tony Lindgren wrote:
>>> This allows the endpoints to work when multiple MUSB glue
>>> layers are built in.
>>
>> Applied on top of 3.18-rc6 mainline and tested successfully on JZ4740.
>> Been able to use ethernet-over-usb to access the internet on
>> device. No issue as far as I'm concerned.
>
> Great that's good to hear and thanks for testing.
>
> Doing the DMA patches here right now.. For the DMA, I've set up
> JZ4740 to use the MUSB_DMA_INVENTRA option by default, is that OK
> or do you have some other DMA hardware on it?
>
> If MUSB_DMA_INVENTRA does not work, and you don't have other DMA
> hardware on it, we can pass MUSB_DMA_INVENTRA and leave the DMA
> function pointers empty, and then the driver will bail out during
> init unless the option for CONFIG_MUSB_PIO_ONLY is set.

Yea... so according to the datasheet there is no DMA support, or at least it 
is not documented in the datasheet's description of the USB core. There is a 
vendor driver for the core which has ifdefs to enable DMA which looks like 
MUSB_DMA_INVENTRA, but I think we never really go that to work too well. So 
the current configuration is to use only PIO.

- Lars

