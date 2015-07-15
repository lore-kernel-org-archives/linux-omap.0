From: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 00/11] USB: OTG/DRD Core functionality
Date: Wed, 15 Jul 2015 10:13:40 +0800
Message-ID: <20150715021339.GB30154@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <CAL1qeaEJ9uX1vgvwO4-ABdGi5C96HZ2jBYWeKiGHJ-uqv6ooGg@mail.gmail.com>
 <20150714005942.GB31197@shlinux2>
 <CAL1qeaHdFv2VQwJVkW-Dv5KxKiJOpfusYuuc50BOkAdp-yvzLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaHdFv2VQwJVkW-Dv5KxKiJOpfusYuuc50BOkAdp-yvzLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Roger Quadros <rogerq@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, jun.li@freescale.com, Mathias Nyman <mathias.nyman@linux.intel.com>, tony@atomide.com, Joao.Pinto@synopsys.com, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 14, 2015 at 11:18:30AM -0700, Andrew Bresticker wrote:
> Hi Peter,
> 
> On Mon, Jul 13, 2015 at 5:59 PM, Peter Chen <peter.chen@freescale.com> wrote:
> > On Mon, Jul 13, 2015 at 12:14:43PM -0700, Andrew Bresticker wrote:
> >> Hi Roger,
> >>
> >> On Wed, Jul 8, 2015 at 3:19 AM, Roger Quadros <rogerq@ti.com> wrote:
> >> > Usage model:
> >> > -----------
> >> >
> >> > - The OTG controller device is assumed to be the parent of
> >> > the host and gadget controller. It must call usb_otg_register()
> >> > before populating the host and gadget devices so that the OTG
> >> > core is aware that it is an OTG device before the host & gadget
> >> > register. The OTG controller must provide struct otg_fsm_ops *
> >> > which will be called by the OTG core depending on OTG bus state.
> >>
> >> I'm wondering if the requirement that the OTG controller be the parent
> >> of the USB host/device-controllers makes sense.  For some context, I'm
> >> working on adding dual-role support for Tegra210, specifically on a
> >> system with USB Type-C.  On Tegra, the USB host-controller and USB
> >> device-controller are two separate IP blocks (XUSB host and XUSB
> >> device) with another, separate, IP block (XUSB padctl) for the USB PHY
> >> and OTG support.  In the non-Type-C case, your OTG framework could
> >> work well, though it's debatable as to whether or not the XUSB padctl
> >> device should be a parent to the XUSB host/device-controller devices
> >> (currently it isn't - it's just a PHY provider).  But in the Type-C
> >> case, it's an off-chip embedded controller that determines the
> >> dual-role status of the Type-C port, so the above requirement doesn't
> >> make sense at all.
> >
> > Hi Andrew,
> >
> > I think your problem is how to add your core driver to manage device and
> > host functionality together, and once you find how (through padctl/type-c
> > controller) to do it based on current code, it will be clear how to use roger
> > proposal framework at that time.
> >
> > Most of current core drivers, we use extcon driver (through gpio) or USB
> > vbus/id pin (through internal registers) to manager roles.
> 
> Right, currently I'm modeling the Type-C controller as an extcon
> device and handle the role-changes in the core drivers, but that
> doesn't really make sense for the non-Type-C case where we use the
> XUSB padctl controller and need a full OTG state-machine.

The full OTG FSM is only applied if your board needs it, you can
disable it through dts. Jun [1] and Roger's patchset are for it.

> Roger's new
> OTG/DRD framework would fit my situation perfectly since it makes the
> host/device-controller drivers independent from all the
> OTG/role-changing logic.  The only issue is the requirement that the
> OTG/DRD controller be the parent device of the host/device
> controllers.
> 

The core device is the parent for host/device device, the OTG core
just use the pointer of it, Roger does an example using dwc3 [2].

[1] http://www.spinics.net/lists/linux-usb/msg127110.html
[2] http://www.spinics.net/lists/linux-usb/msg126999.html
-- 

Best Regards,
Peter Chen
