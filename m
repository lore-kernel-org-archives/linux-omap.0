From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 2/2] Add basic devices support for Nook Color
Date: Wed, 27 Apr 2011 12:12:34 -0400
Message-ID: <1A637068-3F89-4B73-8A36-5278EB69C8CD@linuxhacker.ru>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru> <1303869133-27976-3-git-send-email-green@linuxhacker.ru> <4DB7D89D.7090707@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:59977 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464Ab1D0QMo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 12:12:44 -0400
In-Reply-To: <4DB7D89D.7090707@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

Hello!

 Thanks for the feedback.
On Apr 27, 2011, at 4:49 AM, Mike Rapoport wrote:
>> MMC/SD interface, i2c, usb.
> You should have added these at the first patch instead of Android devices.

So, basically you want all board file changes to come as a single patch, right?

>> ---
>> arch/arm/configs/encore-nookcolor-defconfig | 2015 +++++++++++++++++++++++++++
> The defconfig should be a separate patch. You should rather add encore board
> options to omap2plus_defconfig.

Hm, ok.

>> +static struct i2c_board_info __initdata encore_i2c_bus2_info[] = {
>> +};
>> +
>> +
>> +static struct omap_musb_board_data musb_board_data = {
>> +	.interface_type		= MUSB_INTERFACE_ULPI,
>> +#ifdef CONFIG_USB_MUSB_OTG
>> +	.mode			= MUSB_OTG,
>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>> +	.mode			= MUSB_HOST,
>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>> +	.mode			= MUSB_PERIPHERAL,
>> +#endif
> This kind of ifdefery is handled inside the musb driver. I'd set the mode to
> MUSB_OTG unless you want to explicitly limit it to HOST or PERIPHERAL

Actually it's not.
If I set MUSB_OTG here and then I choose PERIPHERAL mode in the kernel config,
the musb transceiver code will complain about board file and kernel config mismatch.
The Nook Color is advertised as peripheral device, but OTG must be working too
(not totally working at this point) I think there is value to be able to configure it
in two different modes.

Bye,
    Oleg