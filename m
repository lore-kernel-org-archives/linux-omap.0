From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Nokia N800 - USB Host mode issues
Date: Wed, 11 Jul 2007 09:45:18 -0400
Message-ID: <31e679430707110645w7570f5bbn681612bd53317654@mail.gmail.com>
References: <468535CE.5070401@gmx.net> <20070703092628.GA7062@atomide.com>
	<468B9807.90707@gmx.net> <20070711111041.GE19166@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070711111041.GE19166@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Schuster <theBohemian@gmx.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 7/11/07, Tony Lindgren <tony@atomide.com> wrote:
> * Robert Schuster <theBohemian@gmx.net> [070704 05:53]:
> > @Tony: Sorry have to send this again. The list does not like signed mails ..
> >
> > Hi Tony,
> > thanks preparing the 2.6.18 backport. I tried those patches and it works
> > better generally. Throughput seems to be a bit higher now (tested with a
> > USB Ethernet adapter) and device removal/attachment is solid.
> >
> > Still I have some problems but I probably need to tell you how I have
> > modified my N800. The boot process of the N770s detected whether they
> > should set the USB chip to host or client via a configuration variable
> > and loaded a bunch of drivers (usbnet, usbserial, pl2303, asix, usbhid
> > ...). What I basically did is porting this behavior to the N800's
> > linuxrc. So pegasus et al gets loaded when USB host mode is requested
> > furthermore the musb driver is properly initialized (cat 'host' >
> > /sys/.../mode).
> >
> > All connections as host are made with a Mini-B to A cable at whose end a
> >  type A gender changer is connected. I use the same cable without the
> > gender changer for connections made as client.
>
> OK
>
> > So here comes the problems:
> > 1) USB Hostmode is not activated when there was no client-connection
> > first. That means I have to power on the N800 with the cable connected
> > to a host. When the OS' desktop is visible I disconnect the cable and
> > can connect it to the host side of a hub. Everything works fine.
>
> Hmm, I'll take a look at that, but it won't happen until in August.
> Could this be if you don't have any  driver loaded? I believe
> currently the driver needs a gadget or host driver loaded in order
> to be active.

Weird here... I'm using recent omap gittree with n800 and it's quite
fine... I'll try to reproduce the bug and work a bit on that also ;-)

>
> > Here is how the contents of 'mode' and 'cable' behave during those
> > activities:
> >
> >  - N800 boots, echo "host" > ... happens, cable is connected to a host
> >  mode: a_wait_bcon
> >  cable: Mini-B
> >
> >  - cable is unplugged:
> >  mode: a_wait_bcon
> >  cable: Mini-A
> >
> >  - cable is plugged to a hub (as host, of course)
> >  mode: a_host
> >  cable: Mini-A
> >
> > (the following is just for testing purposes)
> >  - cable is unplugged:
> >  mode: a_wait_bcon
> >  cable: Mini-A
> >
> >  - cable is connected to a host
> >  mode: a_wait_bcon
> >  cable: Mini-A
> >
> > So cable does not change back to Mini-B. My guess is that there is some
> > event missing in the driver's state machine that lets it switch to a
> > 'wait for a connection with cable type Mini-A' state.
>
> OK, sounds like there is something wrong with the status detection
> still.

Maybe when we're forcing n800 to host mode by echo'ing sysfs entry is
causing the flakeyness... When I'm using correct mini-A cable, it's
working fine... but there's a problem that I couldn't solve:
When plugging mini-B cable... it sends me 3 cable events... when
unplugging it, just 1.

When plugging mini-A cable it sends me on cable event... and when
unplugging it, 3 events...

This is a bit weird and I couldn't solve this yet.

>
> > 2) Attaching a USB Keyboard which has two USB 1.1 ports built-in fails.
> > First case is that I try to connect it directly (without a hub in
> > between). dmesg gives this:
> >
> > [  647.438598] usb 1-1: new full speed USB device using musb_hdrc and
> > address 8
> > [  647.587036] usb 1-1: ep0 maxpacket = 8
> > [  647.587829] usb 1-1: default language 0x0409
> > [  647.588317] usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
> > [  647.588348] usb 1-1: Product: USB Keyboard + 2P Hub
> > [  647.588592] usb 1-1: uevent
> > [  647.589050] usb 1-1: configuration #1 chosen from 1 choice
> > [  647.589508] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
> > [  647.589660] usb 1-1:1.0: uevent
> > [  647.589813] hub 1-1:1.0: usb_probe_interface
> > [  647.589843] hub 1-1:1.0: usb_probe_interface - got id
> > [  647.589874] hub 1-1:1.0: USB hub found
> > [  647.590118] hub 1-1:1.0: 3 ports detected
> > [  647.590179] hub 1-1:1.0: compound device; port removable status: FRR
> > [  647.590209] hub 1-1:1.0: individual port power switching
> > [  647.590240] hub 1-1:1.0: individual port over-current protection
> > [  647.590270] hub 1-1:1.0: power on to power good time: 44ms
> > [  647.590454] hub 1-1:1.0: hub controller current requirement: 100mA
> > [  647.590484] hub 1-1:1.0: 100mA bus power budget for each child
> > [  647.590637] hub 1-1:1.0: enabling power on all ports
> > [  647.591613] musb_stage0_irq 537: VBUS_ERROR in a_host (91,
> > <VBusValid), retry  #1, port1 00020103
> > [  647.786224] musb_stage0_irq 598: CONNECT (a_host) devctl 5d
> > [  652.696411] usb 1-1: khubd timed out on ep0in len=0/255
> >
> > After the timeout the driver tries it over and over again.
> >
> > If I connect the keyboard through a USB 2.0 hub it shows:
> >
> > [  252.340789] usb 1-1.1.1: new full speed USB device using musb_hdrc
> > and address 7
> > [  252.426483] usb 1-1.1.1: device descriptor read/64, error -71
> > [  252.621673] usb 1-1.1.1: device descriptor read/64, error -71
> > [  252.817535] usb 1-1.1.1: new full speed USB device using musb_hdrc
> > and address 8
> > [  252.903167] usb 1-1.1.1: device descriptor read/64, error -71
> > [  253.098937] usb 1-1.1.1: device descriptor read/64, error -71
> > [  253.294067] usb 1-1.1.1: new full speed USB device using musb_hdrc
> > and address 9
> > [  253.715484] usb 1-1.1.1: device not accepting address 9, error -71
> > [  253.801910] usb 1-1.1.1: new full speed USB device using musb_hdrc
> > and address 10
> > [  254.223297] usb 1-1.1.1: device not accepting address 10, error -71
> > [  254.223968] hub 1-1.1:1.0: state 7 ports 3 chg 0000 evt 0002
> >
> > After that:
> >
> > [  267.701049] musb_stage0_irq 621: BUS RESET
> > [  267.701110] musb_stage2_irq 695: DISCONNECT (a_peripheral) as
> > Peripheral, devctl 19
> >
> > ... (all devices disconnecting) ...
> >
> > [  267.854461] musb_stage0_irq 537: VBUS_ERROR in a_wait_vfall (98,
> > VALID), retry #0, port1 00000100
> > [  267.854522] tusb_source_power 544: VBUS b_idle, devctl 98 otg 171
> > conf c0000001 prcm 00a80500
> >
> > After that I cannot get the driver to enter "a_host" again: Switching to
> > "peripheral" and connecting as client is ok. But if I try "host" cable
> > will show "disconnected" when it is really disconnected but also when it
> > is plugged into the hub (mode contains "a_wait_bcon" all the time).
>
> This is because the keyboard and hubs eat up more than the 100mA N800
> can provide. I assume it works through a powered hub?
>
> But still there's a problem if after the VBUS_ERROR it is unable to
> detect other devices.

Maybe that BABBLE weirdness here, tony??

>
> > This was a lot of text. I will try to understand the behavior from the
> > sources but I hope that someone with better knowledge about the driver
> > may get a clue faster.
>
> Thanks for the information, it helps track down remaining issues. BTW,
> my response time may be long right now as I'm mostly on vacation :)
>
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
