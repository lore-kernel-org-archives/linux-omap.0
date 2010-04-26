From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 0/3] usb: ohci: introduce ohci-hcd driver for omap3
Date: Mon, 26 Apr 2010 11:32:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322986B90@dbde02.ent.ti.com>
References: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
 <h2s305035a41004252254md6918bb6l74ebfe0153ef558b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <h2s305035a41004252254md6918bb6l74ebfe0153ef558b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gclement00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Gregory CLEMENT wrote:
> 	This controller supports multiple interface modes. Only 2 of them
> 	(3-pin DAT/SE0 and 4-pin DP/DM PHY modes) have been tested with this
> 	driver. (However the only change for the other modes is one register
> 	setting for selecting the mode, and the padconf setting for the omap
> 	pads, so I expect it to work correctly).
> 	(Someone did offer to test the 6-pin mode. Still awaiting results...)
> 	

> I am the one who offer to test 6-pin mode. Unfortunally, I still have some problem.
> The current version of our kernel is 2.6.33 so first I try to 
> back port your patch for our version, and so kernel crashes 
> during access to USB controller.
> Then I try to port our kernel to the last version of Linux, 
> but now I can't see any traces on serial port after 
> "Uncompressing Linux... done, booting the kernel..". 
> I am still stuck to these problems which are not really 
> related to your patches.
>  

Could you enable CONFIG_EARLY_PRINTK and add "earlyprintk" to your
bootargs? This might throw up some messages on the console that
can show where the problem is.

Which debug console are you using? Is it an OMAP UART or something
external like in some newer boards?

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
