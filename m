From: "Wael Adel" <showairovic@gmail.com>
Subject: connecting omap and comp using usb cable
Date: Tue, 27 Mar 2007 11:46:52 -0400
Message-ID: <bd205c5f0703270846o18660b1cw6c9440f1bfd27627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

hi all,
i want to communicate with the OMAP kit through the usb cable.

so i made the following small program as a first step  to open the
device as follows: (Note that i have made by taking copy of flash
recovery program omapf1)
********************************************************************************************************
#include <stdio.h>
#include <string.h>
#include <usb.h>

#define OMAP_VENDOR     0x0451
#define OMAP_PRODUCT    0x3f00
#define IN_EP   0x81
#define OUT_EP  0x02

int main(int argc, char *argv[])
{
  usb_init();
  usb_find_busses();


       fprintf (stderr, "Waiting to OMAP-USB connection\n");
        for (;;)
        {
                sleep (1);

                int     n= usb_find_devices ();
                if (n)
                {
                        struct usb_bus  *bus;
                        for (bus= usb_get_busses (); bus; bus= bus->next)
                        {
                                struct usb_device       *dev;

                                for (dev= bus->devices; dev; dev= dev->next)
                                {
                                        usb_dev_handle  *handle;
                                        if (dev->descriptor.idVendor
== OMAP_VENDOR  &&

dev->descriptor.idProduct == OMAP_PRODUCT  &&
                                                (handle= usb_open
(dev)) != NULL)
                                        {
                                                printf("Device is
opened successfully\n");
                                        }
                                }
                        }
                }
        }
  return 0;
}
********************************************************************************************************************

but u guess what?
when i run this small program,i got the following output:

Waiting to OMAP-USB connection

note that i checked that the usb cable is connected well between my
comp and the kit.
Also i checked that jumper 3 is set to pins (1,2)
do u have any ideas why the device is not found?
thanks in advance.
