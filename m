From: =?UTF-8?B?xYF1a2FzeiBQdcWCa2E=?= <lukasz-u2dlg1C4t1k@public.gmane.org>
Subject: PROBLEM: am3517 usb-ohci not working
Date: Wed, 5 Oct 2016 08:36:08 +0200
Message-ID: <CALX2uoP-RN6SmEDOVcaBpJv+4kD2dY_iqxGjZu-5JFxdRAVfjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to make 4.4 kernel working with old am3517 SOM
(http://www.dave.eu/products/som/texas_instruments/am3505-am3517_lizard).

Most of the peripherals are working know - however I got stuck with
usb ohci driver.

Both USB HS ports are connected to ISP1105, hardware is working with
old 2.6.32 based firmware.
I copied the MUXing (muxing is done by u-boot) and TLL/PHY
initialization from old kernel.

My DT entries are:

/ {
        hsusb1_power: hsusb1_power_reg {
                compatible = "regulator-fixed";
                regulator-name = "hsusb1_vbus";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
        };

        hsusb2_power: hsusb2_power_reg {
                compatible = "regulator-fixed";
                regulator-name = "hsusb2_vbus";
                regulator-min-microvolt = <3300000>;
                regulator-max-microvolt = <3300000>;
        };

        hsusb1_phy: hsusb1_phy {
                compatible = "usb-nop-xceiv";
                vcc-supply = <&hsusb1_power>;
        };

        hsusb2_phy: hsusb2_phy {
                compatible = "usb-nop-xceiv";
                vcc-supply = <&hsusb2_power>;
        };
};


&usbhshost {
        port1-mode = "ohci-phy-6pin-datse0";
        port2-mode = "ohci-phy-6pin-datse0";
};

&usbhsehci {
        status = "disabled";
};


CORE_120M_FCLK clock is enabled.

Interrupts are working and kernel is notified when I plug in usb
drive. However usb device is it not enumerated.

I got following debug messages:
usb usb1-port1: Cannot enable. Maybe the USB cable is bad?

and finally:
usb usb1-port1: unable to enumerate USB device

also I can see log like this:
ohci-omap3 48064400.ohci: GetStatus roothub.portstatus [0] =
0x00120101 PRSC PESC PPS CCS

GetStatus message appears multiple times when usb device is plugged in.

I can see FSLSLINESTATE in TLL_CHANNEL_CONF changes when usb device is
connected:

./devmem2 0x48062040
Read at address  0x48062040 (0xb6f9b040): 0x10000CDB

Can you point me what else should I check to make USB HS working in ohci mode?

Thank you  and best regards,
Luke
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
