From: David Brownell <david-b@pacbell.net>
Subject: Re: DVB-T problems with MUSB
Date: Tue, 7 Oct 2008 18:17:00 -0700
Message-ID: <200810071817.01014.david-b@pacbell.net>
References: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl> <20081007231032.GB669@inside.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:22449 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752860AbYJHBRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 21:17:04 -0400
In-Reply-To: <20081007231032.GB669@inside.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kimmo Jukarainen <kimju-omap@inside.org>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-dvb@linuxtv.org

On Tuesday 07 October 2008, Kimmo Jukarainen wrote:
> On Tue, Oct 07, 2008 at 09:03:42PM +0200, Koen Kooi wrote:
> > Is this a problem with MUSB, omap dma or the dvb stack?
> 
> I'd say dvb stack. This small patch fixed my dvb-t stick with
> a omap2 board:
> 
> http://www.linuxtv.org/pipermail/linux-dvb/2008-January/023040.html

Looks like a fair fix, at a quick look.

I'm kind of surprised that bug has been known for what
looks like about a year now, with a trivial fix that
hasn't yet been merged through the DVB tree ...


> --- linux-2.6.20.4.orig/drivers/media/dvb/dvb-usb/usb-urb.c 2007-03-23 20:52:51.000000000 +0100
> +++ linux-2.6.20.4/drivers/media/dvb/dvb-usb/usb-urb.c 2007-10-25 12:19:50.000000000 +0200
> @@ -152,7 +152,8 @@
>  	stream->props.u.bulk.buffersize,
>  	usb_urb_complete, stream);
>
> -	stream->urb_list[i]->transfer_flags = 0;
> +	stream->urb_list[i]->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
> +	stream->urb_list[i]->transfer_dma = stream->dma_addr[i];
>  	stream->urbs_initialized++;
>  }
>  return 0;
