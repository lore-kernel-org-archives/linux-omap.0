From: "Wael Adel" <showairovic@gmail.com>
Subject: Re: connecting omap and comp using usb cable
Date: Tue, 27 Mar 2007 12:33:08 -0400
Message-ID: <bd205c5f0703270933g57405fc1xe72ae9b31b271a12@mail.gmail.com>
References: <bd205c5f0703270846o18660b1cw6c9440f1bfd27627@mail.gmail.com>
	<31e679430703270851q3f1e1f6o57a88339accd8fa9@mail.gmail.com>
	<bd205c5f0703270858y79c08e9dg65dfe1a04f4087fc@mail.gmail.com>
	<bd205c5f0703270910j6e4e9587m7855a0816433cf39@mail.gmail.com>
	<31e679430703270917j7bb9f107uf44f9fd91750f880@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430703270917j7bb9f107uf44f9fd91750f880@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/27/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> Hello Wael,
>
> On 3/27/07, Wael Adel <showairovic@gmail.com> wrote:
> > On 3/27/07, Wael Adel <showairovic@gmail.com> wrote:
> > > i m using A-A usb cable to connect my comp to the OMAP kit.OK
> > > so that the OMAP kit would b the device (slave) of the usb bus while
> > > the host of the bus would b my computer ?
>
> Yes, that's right. But I think you don't need to write another
> application if you can use
> what's already there.
>
> Try to build your device's kernel with support to USB Gadget. And
> enable CONFIG_USB_ETH. This'll build a module called g_ether. This
> module will let your USB Device work as a Ethernet card. This way you
> will be able to ssh into the device and work on that.

but my problem is not at the device side, it is at the host side.
note that i tried  to run the code i have sent at the host side, this
was written in the flash recovery program.

As for the device side i load the gadgetfs module not ethernet module
but i may try what u have said to me, but still dont know how can the
host read data from the device(OMAP kit)

> I don't know if this will help ya... I don't know what's your objectives.
>
> If you could tell us a bit more...

All what i want is just to make OMAP kit  be able to send/receive data
from my comp and
also i want to make my comp be able to receive/send data from/to my
device (OMAP)

> > > is there any problem in that?
>
> No problem at all.. this is the correct way to do it.
>
> > >
> > > On 3/27/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> > > > What do you mean with "connect to OMAP" ??
> > > > Why don't you use g_serial to emulate a tty terminal through usb or
> > > > g_ether to emulate a network card through USB ??
> > > >
> > > > I think g_ether would easier... as long as you can connect to OMAP
> > > > board using SSH or Telnet or something like that.
> > > >
> > > >
> > > >
> > > >
> > > > On 3/27/07, Wael Adel <showairovic@gmail.com> wrote:
> > > > > hi all,
> > > > > i want to communicate with the OMAP kit through the usb cable.
> > > > >
> > > > > so i made the following small program as a first step  to open the
> > > > > device as follows: (Note that i have made by taking copy of flash
> > > > > recovery program omapf1)
> > > > >
> > > >
> > >
> ********************************************************************************************************
> > > > > #include <stdio.h>
> > > > > #include <string.h>
> > > > > #include <usb.h>
> > > > >
> > > > > #define OMAP_VENDOR     0x0451
> > > > > #define OMAP_PRODUCT    0x3f00
> > > > > #define IN_EP   0x81
> > > > > #define OUT_EP  0x02
> > > > >
> > > > > int main(int argc, char *argv[])
> > > > > {
> > > > >   usb_init();
> > > > >   usb_find_busses();
> > > > >
> > > > >
> > > > >        fprintf (stderr, "Waiting to OMAP-USB connection\n");
> > > > >         for (;;)
> > > > >         {
> > > > >                 sleep (1);
> > > > >
> > > > >                 int     n= usb_find_devices ();
> > > > >                 if (n)
> > > > >                 {
> > > > >                         struct usb_bus  *bus;
> > > > >                         for (bus= usb_get_busses (); bus; bus=
> > > bus->next)
> > > > >                         {
> > > > >                                 struct usb_device       *dev;
> > > > >
> > > > >                                 for (dev= bus->devices; dev; dev=
> > > > dev->next)
> > > > >                                 {
> > > > >                                         usb_dev_handle  *handle;
> > > > >                                         if (dev->descriptor.idVendor
> > > > > == OMAP_VENDOR  &&
> > > > >
> > > > > dev->descriptor.idProduct == OMAP_PRODUCT  &&
> > > > >                                                 (handle= usb_open
> > > > > (dev)) != NULL)
> > > > >                                         {
> > > > >                                                 printf("Device is
> > > > > opened successfully\n");
> > > > >                                         }
> > > > >                                 }
> > > > >                         }
> > > > >                 }
> > > > >         }
> > > > >   return 0;
> > > > > }
> > > > >
> > > >
> > >
> ********************************************************************************************************************
> > > > >
> > > > > but u guess what?
> > > > > when i run this small program,i got the following output:
> > > > >
> > > > > Waiting to OMAP-USB connection
> > > > >
> > > > > note that i checked that the usb cable is connected well between my
> > > > > comp and the kit.
> > > > > Also i checked that jumper 3 is set to pins (1,2)
> > > > > do u have any ideas why the device is not found?
> > > > > thanks in advance.
> > > > > _______________________________________________
> > > > > Linux-omap-open-source mailing list
> > > > > Linux-omap-open-source@linux.omap.com
> > > > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > > > >
> > > >
> > > >
> > > > --
> > > > Best Regards,
> > > >
> > > > Felipe Balbi
> > > > felipebalbi@users.sourceforge.net
> > > >
> > >
> >
>
>
> --
> Best Regards,
>
> Felipe Balbi
> felipebalbi@users.sourceforge.net
>
