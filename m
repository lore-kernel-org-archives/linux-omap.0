From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 2/2] Add basic devices support for Nook Color
Date: Thu, 28 Apr 2011 09:14:36 +0300
Message-ID: <4DB905CC.7030907@compulab.co.il>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru> <1303869133-27976-3-git-send-email-green@linuxhacker.ru> <4DB7D89D.7090707@compulab.co.il> <1A637068-3F89-4B73-8A36-5278EB69C8CD@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:34643
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751821Ab1D1GHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Apr 2011 02:07:05 -0400
In-Reply-To: <1A637068-3F89-4B73-8A36-5278EB69C8CD@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

(adding Felipe to cc)

Felipe, can you comment on the mUSB part, please?

On 04/27/11 19:12, Oleg Drokin wrote:
> Hello!
> 
>  Thanks for the feedback.
> On Apr 27, 2011, at 4:49 AM, Mike Rapoport wrote:
>>> MMC/SD interface, i2c, usb.
>> You should have added these at the first patch instead of Android devices.
> 
> So, basically you want all board file changes to come as a single patch, right?

I would split you series into three patches:
1) TWL updates
2) addition of board-encore
3) defconfig updates

The patch that adds board-encore would include MMC, i2c and mUSB.

>>> ---
>>> arch/arm/configs/encore-nookcolor-defconfig | 2015 +++++++++++++++++++++++++++
>> The defconfig should be a separate patch. You should rather add encore board
>> options to omap2plus_defconfig.
> 
> Hm, ok.
> 
>>> +static struct i2c_board_info __initdata encore_i2c_bus2_info[] = {
>>> +};
>>> +
>>> +
>>> +static struct omap_musb_board_data musb_board_data = {
>>> +	.interface_type		= MUSB_INTERFACE_ULPI,
>>> +#ifdef CONFIG_USB_MUSB_OTG
>>> +	.mode			= MUSB_OTG,
>>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>>> +	.mode			= MUSB_HOST,
>>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>>> +	.mode			= MUSB_PERIPHERAL,
>>> +#endif
>> This kind of ifdefery is handled inside the musb driver. I'd set the mode to
>> MUSB_OTG unless you want to explicitly limit it to HOST or PERIPHERAL
> 
> Actually it's not.
> If I set MUSB_OTG here and then I choose PERIPHERAL mode in the kernel config,
> the musb transceiver code will complain about board file and kernel config mismatch.
> The Nook Color is advertised as peripheral device, but OTG must be working too
> (not totally working at this point) I think there is value to be able to configure it
> in two different modes.

Frankly, I haven't tried choosing different modes in the kernel config and in
the board data. Still, I believe that board data should define desired operation
mode and the driver should do the best effort to enable the controller in the
desired mode.

> Bye,
>     Oleg


-- 
Sincerely yours,
Mike.
