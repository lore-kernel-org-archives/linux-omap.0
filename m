From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: OMAP5912 and USB PID/VID
Date: Wed, 17 Oct 2007 00:19:04 +0300
Message-ID: <31e679430710161419t77a98be3x94f2fb5a82c7bba5@mail.gmail.com>
References: <6ED95C184239FC419DFE88BA479737655FF7455F@mailnt.doble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <6ED95C184239FC419DFE88BA479737655FF7455F@mailnt.doble.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Grubner, Martin" <mgrubner@doble.com>
Cc: "Abercrombie, Gary" <gabercrombie@doble.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/16/07, Grubner, Martin <mgrubner@doble.com> wrote:
> Hello,
>
> I have designed a new board with the OMAP5912 device and wanted to know
> if there is a way to get the proper VID/PID into the device via say the
> UART1 serial port without the need for the Emulator/JTAG. If  the
> emulator is the only way what steps are needed to get the device
> programmed?

If you're running linux in it, you just need to change the values in
gadget drivers, let's say you're using gadget zero
(drivers/usb/gadget/zero.c) you would change the following lines:

/* Thanks to NetChip Technologies for donating this product ID.
 *
 * DO NOT REUSE THESE IDs with a protocol-incompatible driver!!  Ever!!
 * Instead:  allocate your own, using normal USB-IF procedures.
 */
#ifndef	CONFIG_USB_ZERO_HNPTEST
#define DRIVER_VENDOR_NUM	0x0525		/* NetChip */
#define DRIVER_PRODUCT_NUM	0xa4a0		/* Linux-USB "Gadget Zero" */
#else
#define DRIVER_VENDOR_NUM	0x1a0a		/* OTG test device IDs */
#define DRIVER_PRODUCT_NUM	0xbadd
#endif

In case of gadget zero, it can also become the otg test device, so
changing only the first 2 defines is enough ;-)

>
> Thank you very much,
>
> -Martin
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
