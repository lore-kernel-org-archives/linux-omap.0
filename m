From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: double_buffer_not_ok compile error
Date: Mon, 21 Feb 2011 14:54:27 +0100
Message-ID: <4D626E93.3070501@matrix-vision.de>
References: <4D6261C8.1090605@matrix-vision.de> <20110221132438.GD23087@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:56926 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab1BUOEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 09:04:44 -0500
In-Reply-To: <20110221132438.GD23087@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Felipe,

Sorry, thanks.  I tried to avoid getting that reply by searching the
mailing list to see whether this was already discovered.  I searched for
"double_buffer_not_ok" and "musb_host" on the mailing list but didn't
see anything newer than the original patch.

Where is the correct place to search for such a recent fix?  Where is
Greg's queue?

-Michael

On 02/21/2011 02:25 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Feb 21, 2011 at 01:59:52PM +0100, Michael Jones wrote:
>> In commit 0662481855c389b75a0a54c32870cc90563d80a9, the member
>> 'double_buffer_not_ok' was added to 'struct musb', but only inside
>> #ifdef CONFIG_USB_GADGET_MUSB_HDRC.  In musb_host.c, this member is used
>> outside of the same #ifdef, so I get a compile error because I have
>> CONFIG_USB_GADGET_MUSB_HDRC=n (because I have CONFIG_USB_GADGET_OMAP=y).
>>
>> here is the error:
>> drivers/usb/musb/musb_host.c: In function 'musb_rx_reinit':
>> drivers/usb/musb/musb_host.c:612: error: 'struct musb' has no member
>> named 'double_buffer_not_ok'
>>
>> I'm not familiar enough with this to propose a correct patch, but for
>> example with the patch below, I can compile the kernel.  Maybe the
>> member definition can just be taken out of the #ifdef.
>>
>> Can you propose a proper fix for this?
> 
> There's already a fix for that queued on Greg's queue ;-)
> 
> Thanks though
> 
> Here it is:
> 
> commit 5990378b393429244559f4750f2ee3a50929b932
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Fri Feb 11 10:00:02 2011 +0200
> 
>     usb: musb: fix build breakage
>     
>     commit 0662481855c389b75a0a54c32870cc90563d80a9
>     (usb: musb: disable double buffering when it's broken),
>     introduced a compile error when gadget API is disabled.
>     
>     Fix it.
>     
>     Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index d74a811..e6400be 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -488,6 +488,15 @@ struct musb {
>         unsigned                set_address:1;
>         unsigned                test_mode:1;
>         unsigned                softconnect:1;
> +
> +       u8                      address;
> +       u8                      test_mode_nr;
> +       u16                     ackpend;                /* ep0 */
> +       enum musb_g_ep0_state   ep0_state;
> +       struct usb_gadget       g;                      /* the gadget */
> +       struct usb_gadget_driver *gadget_driver;        /* its driver */
> +#endif
> +
>         /*
>          * FIXME: Remove this flag.
>          *
> @@ -501,14 +510,6 @@ struct musb {
>          */
>         unsigned                double_buffer_not_ok:1 __deprecated;
>  
> -       u8                      address;
> -       u8                      test_mode_nr;
> -       u16                     ackpend;                /* ep0 */
> -       enum musb_g_ep0_state   ep0_state;
> -       struct usb_gadget       g;                      /* the gadget */
> -       struct usb_gadget_driver *gadget_driver;        /* its driver */
> -#endif
> -
>         struct musb_hdrc_config *config;
>  
>  #ifdef MUSB_CONFIG_PROC_FS
> 


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
