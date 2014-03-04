From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: RE: Help needed USB hub disconnected at resume
Date: Tue, 4 Mar 2014 22:34:56 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local>,<F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local>
 <53146225.8040403@ti.com>,<531472B3.1060104@compulab.co.il>
 <F690310232FDDF4AB457E8B3EF90DDE0AA85E7F2@MARCM-SBS2011.marcmltd.local>
 <5315761D.8080103@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpout17.bt.lon5.cpcloud.co.uk ([65.20.0.137]:42273 "EHLO
	smtpout17.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754764AbaCDWfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 17:35:38 -0500
In-Reply-To: <5315761D.8080103@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Igor Grinberg' <grinberg@compulab.co.il>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Igor Grinberg
> Sent: 04 March 2014 06:44
> To: Marc Murphy; Roger Quadros; linux-omap@vger.kernel.org
> Subject: Re: Help needed USB hub disconnected at resume
> 
> On 03/03/14 16:11, Marc Murphy wrote:
> > Hi Igor
> >
> > The Hub is a Microchip USB2513B-AEZG and is connected to EHCI controller
> port via the DUP_P and DUP_N pins.  There is a reset applied to the chip at
> power on.
> >
> 
> If the reset signal is sw controllable, you might want to toggle it before the
> EHCI controller resumes.
>
> There is also a USB phy on the way from EHCI controller to the hub.
> You might also want to check if the phy resumes correctly.
> Which phy do you use and how is it reset?

I have now had a look with the schematics and the hardware engineer.  
The AM3517 has a PHY connected and it is a SMSC USB3320.  The device has a reset connection via GPIO_25.

I have it configured as follows

#define TAM3517_EHCI_RESET  25

static const struct usbhs_omap_board_data tam3517_ehci_pdata __initconst = {
    .port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
    .port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
    .port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,

    .phy_reset  = true,
    .reset_gpio_port[0]  = TAM3517_EHCI_RESET,
    .reset_gpio_port[1]  = -EINVAL,
    .reset_gpio_port[2]  = -EINVAL
};

static __init void tam3517_ehci_init(void)
{
    /* Configure GPIO for EHCI port */
    omap_mux_init_gpio(TAM3517_EHCI_RESET, OMAP_PIN_OUTPUT);

    gpio_request(TAM3517_EHCI_RESET, "USB_RESET");
    gpio_direction_output(TAM3517_EHCI_RESET, 1);
    gpio_export(TAM3517_EHCI_RESET, 0);
    msleep(100);
    gpio_set_value(TAM3517_EHCI_RESET, 1);

    usbhs_init(&tam3517_ehci_pdata);
}

I have tried without the phy reset control but stull get the same behaviour.

I have asked for some tap wires onto the control signals for the Phy and I will  have a look with a scope to make sure the pin is toggled correctly.

If you see anything wrong with the initialisation then please let me know.

Thanks
Marc

> 
> > Regards
> > Marc
> > ________________________________________
> > From: Igor Grinberg [grinberg@compulab.co.il]
> > Sent: 03 March 2014 12:16
> > To: Roger Quadros; Marc Murphy; linux-omap@vger.kernel.org
> > Subject: Re: Help needed USB hub disconnected at resume
> >
> > On 03/03/14 13:06, Roger Quadros wrote:
> >> Hi Marc,
> >>
> >> On 03/03/2014 12:04 PM, Marc Murphy wrote:
> >>> Hi,
> >>> I am using the latest stable 3.4.80 kernel with some changes to get the
> EMAC Phy to initialise correctly after a suspend/resume.  The platform is
> AM3517 with most of the system working nice and smoothly. I have 1 issue
> though and need some advice/help to get the system to use the USB hub I
> have connected to the EHCI controller after a suspend to memory and
> resume.
> >>>
> >>> At boot all is recognised;
> >>>
> >>> [    1.486816] usbcore: registered new interface driver cdc_ether
> >>> [    1.493255] usbcore: registered new interface driver cdc_ncm
> >>> [    1.499450] usbcore: registered new interface driver qmi_wwan
> >>> [    1.506622] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> >>> [    1.513580] ehci-omap.0 supply hsusb0 not found, using dummy
> regulator
> >>> [    2.521881] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
> >>> [    2.528411] ehci-omap ehci-omap.0: new USB bus registered, assigned
> bus number 1
> >>> [    2.536468] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
> >>> [    2.553070] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
> >>> [    2.559295] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002
> >>> [    2.566436] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> >>> [    2.574035] usb usb1: Product: OMAP-EHCI Host Controller
> >>> [    2.579620] usb usb1: Manufacturer: Linux 3.4.80 ehci_hcd
> >>> [    2.585296] usb usb1: SerialNumber: ehci-omap.0
> >>> [    2.591278] hub 1-0:1.0: USB hub found
> >>> [    2.595306] hub 1-0:1.0: 3 ports detected
> >>>
> >>> And I can see everything OK.
> >>>
> >>> # lsusb
> >>> Bus 001 Device 002: ID 0424:2513 Standard Microsystems Corp. 2.0 Hub
> >>> Bus 002 Device 002: ID 05e3:0718 Genesys Logic, Inc. IDE/SATA
> >>> Adapter Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root
> >>> hub Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >>> Bus 001 Device 003: ID 1199:68a2 Sierra Wireless, Inc.
> >>> #
> >>> #
> >>> # echo mem > /sys/power/state
> >>> [   73.736572] PM: Syncing filesystems ... done.
> >>> [   73.743530] Freezing user space processes ... (elapsed 0.01 seconds)
> done.
> >>> [   73.766784] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> >>> [   73.959289] davinci_mdio davinci_mdio.0: timed out waiting for idle
> >>> [   73.968872] PM: suspend of devices complete after 170.410 msecs
> >>> [   73.975433] PM: late suspend of devices complete after 0.305 msecs
> >>> [   73.982635] PM: noirq suspend of devices complete after 0.732 msecs
> >>> [   83.430450] Powerdomain (core_pwrdm) didn't enter target state 1
> >>> [   83.436737] Could not enter target state in pm_suspend
> >>> [   83.443176] PM: noirq resume of devices complete after 0.915 msecs
> >>>  [   83.450164] PM: early resume of devices complete after 0.274 msecs
> >>> [   83.457336] <6>Waiting for PHY clock good...
> >>> [   83.463287] davinci_mdio davinci_mdio.0: resetting idled controller
> >>> [   83.471343] net eth0: attached PHY driver [SMSC LAN8710/LAN8720]
> (mii_bus:phy_addr=davinci_mdio-0:00, id=7c0f1)
> >>> [   84.771881] PM: resume of devices complete after 1315.185 msecs
> >>> [   84.778472] Restarting tasks ...
> >>> [   84.782379] usb 1-1: USB disconnect, device number 2
> >>> [   84.790557] done.
> >>> [   84.792938] mmc0: mmc_rescan_try_freq: trying to init card at 400000
> Hz
> >>> sh: write error:[   84.800781] usb 1-1.1: USB disconnect, device number 3
> >>>  Operation not p[   84.808349] qmi_wwan 1-1.1:1.8: wwan0: unregister
> 'qmi_wwan' usb-ehci-omap.0-1.1, Sierra Wireless wwan/QMI device
> >>> ermitted
> >>> [   84.859191] mmc1: mmc_rescan_try_freq: trying to init card at 400000
> Hz
> >>> [   86.490356] PHY: davinci_mdio-0:00 - Link is Up - 100/Full
> >>> #
> >>> #
> >>> # lsusb
> >>> Bus 002 Device 002: ID 05e3:0718 Genesys Logic, Inc. IDE/SATA
> >>> Adapter Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root
> >>> hub Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub #
> >>>
> >>> Is there any relevant patch out there that would address the issue that I
> see ?
> >>
> >> Does this happen because of OFF mode?
> >> Can you please try the tests with off mode disabled?
> >>
> >> e.g.
> >> mount -t debugfs none /sys/kernel/debug echo 0 >
> >> /sys/kernel/debug/pm_debug/enable_off_mode
> >> suspend & resume
> >
> > AFAIK, AM3517 does not have OFF mode.
> > We had something similar with runtime pm...
> > It might be useful to know which hub is this and how is it connected...
> >
> >>
> >> Also please send the output of /sys/kernel/debug/pm_debug/count
> >> before suspend and after resume. Thanks.
> >
> >
> >
> > --
> > Regards,
> > Igor.
> >
> 
> --
> Regards,
> Igor.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
