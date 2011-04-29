From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] Add basic devices support for Nook Color
Date: Fri, 29 Apr 2011 12:21:42 +0300
Message-ID: <20110429092139.GB2529@legolas.emea.dhcp.ti.com>
References: <1303869133-27976-1-git-send-email-green@linuxhacker.ru>
 <1303869133-27976-3-git-send-email-green@linuxhacker.ru>
 <4DB7D89D.7090707@compulab.co.il>
 <1A637068-3F89-4B73-8A36-5278EB69C8CD@linuxhacker.ru>
 <4DB905CC.7030907@compulab.co.il>
 <5E4912CA-9E7A-423B-A8FA-DF16C0A4D242@linuxhacker.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:32959 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008Ab1D2JVs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 05:21:48 -0400
Received: by fxm17 with SMTP id 17so3301787fxm.5
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 02:21:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5E4912CA-9E7A-423B-A8FA-DF16C0A4D242@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Thu, Apr 28, 2011 at 12:10:09PM -0400, Oleg Drokin wrote:
> Hello!
> 
> On Apr 28, 2011, at 2:14 AM, Mike Rapoport wrote:
> >>>> +static struct omap_musb_board_data musb_board_data = {
> >>>> +	.interface_type		= MUSB_INTERFACE_ULPI,
> >>>> +#ifdef CONFIG_USB_MUSB_OTG
> >>>> +	.mode			= MUSB_OTG,
> >>>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> >>>> +	.mode			= MUSB_HOST,
> >>>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> >>>> +	.mode			= MUSB_PERIPHERAL,
> >>>> +#endif
> >>> This kind of ifdefery is handled inside the musb driver. I'd set the mode to
> >>> MUSB_OTG unless you want to explicitly limit it to HOST or PERIPHERAL
> >> Actually it's not.
> >> If I set MUSB_OTG here and then I choose PERIPHERAL mode in the kernel config,
> >> the musb transceiver code will complain about board file and kernel config mismatch.
> >> The Nook Color is advertised as peripheral device, but OTG must be working too
> >> (not totally working at this point) I think there is value to be able to configure it
> >> in two different modes.
> > Frankly, I haven't tried choosing different modes in the kernel config and in
> > the board data. Still, I believe that board data should define desired operation
> > mode and the driver should do the best effort to enable the controller in the
> > desired mode.
> 
> The desired operation mode is dependent on musb configuration.
> E.g. see n8x0 board file for the example of the same thing.

Only development platforms should have that ifdef trickery. The idea of
that field is to tell the driver how the board is wired.
Host/Peripheral/OTG support is hardwired by the circuitry around the
USB receptacle you have on your board.

-- 
balbi
