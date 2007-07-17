From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: USB functionality on OMAP2430 SDP
Date: Wed, 18 Jul 2007 00:10:36 +0530
Message-ID: <78d6ed630707171140u7358c429v37d1869155748f60@mail.gmail.com>
References: <20070704142900.67B087AF01@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070704142900.67B087AF01@ws5-10.us4.outblaze.com>
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
To: Kanagesh R <kanagesh@india.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

*Kanagesh/all*

I have been trying to use *OAMP2430 SDP FSUSB port 0 - J51* act as a host.
I have made S6-6 ON and S-6-7 ON which is mandatory to route the signal
through this USB.
But when I connect my mass storage device to the port its not getting
powered up.
It should provide a voltage of 5 volts acrosss V+ and GND pin so that the
OMAP board can act as a host and power up the device and when I check the
voltage across the ports , its giving me a strange figure of 3.2 Volts .

Can any one explain that are there any hardware settings that need to be
carried out to configure the J51 as a host port or we need to do this via
software but I am not sure if it will happpen through s/w since thre are no
power interfaces of OMAP board with the host controller. Only clock
interface is there through PRCM. The power needs to be supplied through
ISP1301 transceiver but unfortunately I am not able to trace how it needs to
be given

Kindly help me in this issue.


Thnaks & Regards

Aman

On 7/4/07, *Kanagesh *R <kanagesh@india.com> wrote:
>
> > ----- Original Message -----
> > From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
> > To: "Kanagesh R" <kanagesh@india.com>,
> linux-omap-open-source@linux.omap.com
> > Subject: RE: USB functionality on OMAP2430 SDP
> > Date: Tue, 3 Jul 2007 09:58:59 -0500
> >
> >
> >
> > > May I have the .config file for the kernel or the configurations for
> the
> > > USB and ISP1301 that you made to get the kernel working with USB
> Gadget on
> > > the SDP?
> > >
> > > Could you also tell me the positions of Switch 6 (HSUSB_nFS) and
> Switch 7
> > > (HSVBUS_nFS) in Dip Switch S6 on the SDP?
> > >
> >
> > Attached is the defconfig that we used. You also need to set SW6 [6
> > ON, 7 ON] on SDP in order to enable FSUSB.
> >
> > Regards,
> > Khasim
> > << FSUSBGadget.config >>
>
> >
>
> Hello Khasim,
>
> I built the kernel with the same configurations as in the config file
> received.  I am still not able to get the interrupts on insertion of the USB
> cable.  A log from my serial console is as follows:
>
> root]#/sbin/ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 08:00:28:01:0A:DE
>          inet addr:192.168.13.153  Bcast:192.168.13.255  Mask:
> 255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2159 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:897 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:268 txqueuelen:1000
>          RX bytes:2717362 (2.5 MiB)  TX bytes:147602 (144.1 KiB)
>          Interrupt:245 Base address:0x4300 DMA chan:ff
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> [root]#modprobe g_ether
> usb0: Ethernet Gadget, version: May Day 2005
> usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
> usb0: MAC 36:4c:87:28:3f:83
> usb0: HOST MAC 12:a2:e0:58:f7:4c
> usb0: RNDIS ready
> isp1301_omap 0-002d: B-Peripheral sessions ok
> [root]#/sbin/ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 08:00:28:01:0A:DE
>          inet addr:192.168.13.153  Bcast:192.168.13.255  Mask:
> 255.255.255.0
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2517 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:1059 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:296 txqueuelen:1000
>          RX bytes:3125456 (2.9 MiB)  TX bytes:173494 (169.4 KiB)
>          Interrupt:245 Base address:0x4300 DMA chan:ff
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> usb0      Link encap:Ethernet  HWaddr 36:4C:87:28:3F:83
>          BROADCAST MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> [root]#
> [root]#
> [root]#
> [root]#
> < plug in USB Cable now >
> [root]#cat /proc/interrupts
>           CPU0
> 12:          0   OMAP24XX DMA IRQ demux
> 24:          0   omap24xxcam
> 25:          0   OMAP2 Display
> 38:       8591   OMAP2 gptimer
> 39:          0   OMAP2 gptimer
> 56:        477   i2c-omap243x-1
> 57:        138   i2c-omap243x-2
> 58:          0   OMAP HDQ
> 65:          0   mcspi_master_isr
> 66:          0   mcspi_master_isr
> 72:        328   serial
> 75:          0   omap_udc
> 76:          0   omap_udc pio
> 77:          0   omap_udc iso
> 83:          9   omap2430-mmc1
> 86:          9   omap2430-mmc2
> 91:          0   mcspi_master_isr
> 120:          0   omap_tsc2046_ts
> 174:          0   isp1301_omap
> 245:       3012   eth0
> 258:          0   TWL4030 Keypad
> 262:          0   omap-twl4030rtc
> 265:          0   omap2430-mmc1
> 266:          0   omap2430-mmc2
> Err:          0
> [root@OMAP2430SDP /]#
>
> When I plug in the cable to the SDP board I am supposed to get the USB
> interrupts, which are not occuring.
>
> The only difference between the configuration of my kernel from the
> configuration that I received  is that I am using a non-EABI toolchain to
> build the kernel sources.  I built this toolchain using crosstool.  The
> SDRAM settings that I was using intially was PRCM_5A but I have made changes
> in the kernel and u-boot for SDRAM settings as per PRCM_2 aswell.
>
> Some more information:
> - On the host system, I am running Fedora Core 5.
> - My /proc/bus/devices/usb does not show any entry for 'Gadget'.
> - On the board, I have ensured that switches 6 and 7 of Dip Switch S6 is
> in the 'On' position
> - Of the four USB connectors on the SDP board, I am connecting to
> connector J51 (connector closest to the DIP switches), which is the
> interface to ISP1301
> - The cable I am using is a USB Type-A to Mini-B cable
>
> I have checked the Interrupt enable registers for IRQs that the omap_udc
> driver is registering to and ensured that they have been unmasked and
> enabled.  What could I do to check on the interrupts?
>
> Thank you very much for your time.
>
> Regards,
> Kanagesh
>
>
>
> =
>
>
> --
> _______________________________________________
> Search for products and services at:
> http://search.mail.com
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
