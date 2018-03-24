From: Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Sat, 24 Mar 2018 08:59:28 -0500
Message-ID: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
References: <20180309023750.108942-1-tony@atomide.com>
         <20180322135553.GA27648@amd> <20180322164633.GF5799@atomide.com>
         <20180322192843.GA17189@amd>
         <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
         <20180323105455.GB21644@amd>
         <20180323113521.45va72bhzis6ym6m@earth.universe>
         <20180323201343.GC23658@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323201343.GC23658@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> On Fri 2018-03-23 12:35:21, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Fri, Mar 23, 2018 at 11:54:55AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > Do you have the related dts patches picked from next?
> > > > > > 
> > > > > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port
> > > > > > naming")
> > > > > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600
> > > > > > USB PHY")
> > > > > > 
> > > > > > But yeah all you need to do is have phy-mapphone-mdm6600
> > > > > > and
> > > > > > ohci-platform loaded and then ifconfig should show four
> > > > > > wwan
> > > > > > interfaces being added.
> > > > > 
> > > > > ifconfig? I thought I should get /dev/ttyUSB0..3?
> > > > 
> > > > I believe they are QMI via qmi_wwan, not TTYs.
> > > 
> > > Well, qmicli expects device path... and I see nothing on
> > > ifconfig. Any
> > > idea how the device would be named?
> > > 
> > > But I believe it just does not work, see the qcserial experiment
> > > with
> > > new_id below.
> > 
> > Dan is right, you need qmi_wwan driver. qmicli expects
> > /dev/cdc-wdm<num> device. I use this on Droid 4:
> > 
> > qmicli -d /dev/cdc-wdm0 --some-other-option
> 
> Aha, there's ./drivers/usb/serial/usb_wwan.c and there's
> ./drivers/net/usb/qmi_wwan.o . That confused me.
> 
> qmicli now works for me, thanks!
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> Does ofonod work for you? I could not get that one to work...

Because it's looking for a Gobi modem but the MDM6600 isn't one and
doesn't expose that layout (and doesn't really need to anyway).  I
don't think ofono has a generic QMI driver, so you'd either need to for
ce it to use the telitqmi or quectelqmi drivers, or write your own
generic QMI one.

Dan

> ofonod[4083]: plugins/udevng.c:create_modem()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: plugins/udevng.c:create_modem() driver=gobi
> ofonod[4083]: src/modem.c:ofono_modem_create() name: (null), type:
> gobi
> ofonod[4083]: plugins/udevng.c:setup_gobi()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm0 255/251/255
> 05 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan0 255/251/255 05
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm1 255/251/255
> 06 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan1 255/251/255 06
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm2 255/251/255
> 07 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan2 255/251/255 07
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm3 255/251/255
> 08 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan3 255/251/255 08
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:destroy_modem()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: src/modem.c:ofono_modem_remove() 0x5eb380
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan0
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm1
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan1
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm2
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan2
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm3
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan3
> ofonod[4083]: plugins/upower.c:upower_connect() upower connect
> ofonod[4083]: plugins/hfp_hf_bluez5.c:connect_handler() Registering
> External Profile handler ...
> 
> 									
> Pavel
