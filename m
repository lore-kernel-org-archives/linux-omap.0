From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/4] drivers: usb: phy: add a new driver for usb
 part of control module
Date: Fri, 25 Jan 2013 12:29:43 +0000
Message-ID: <20130125122943.GB16795@e106331-lin.cambridge.arm.com>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-2-git-send-email-kishon@ti.com>
 <20130125110141.GK3075@e106331-lin.cambridge.arm.com>
 <20130125111120.GP15886@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130125111120.GP15886@arwen.pp.htv.fi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

[...]

> > > +OMAP CONTROL USB
> > > +
> > > +Required properties:
> > > + - compatible: Should be "ti,omap-control-usb"
> > > + - reg : Address and length of the register set for the device. It contains
> > > +   the address of "control_dev_conf" and "otghs_control" or "phy_power_usb"
> > 
> > Could you not use '-' over '_' here?
> 
> that's part of omap hwmod.

Aha, that makes sense (unlike my original comment, now I reread it). Sorry for
the noise.

> > > +   depending upon omap4 or omap5.
> > > + - reg-names: The names of the register addresses corresponding to the registers
> > > +   filled in "reg".
> > > + - ti,type: This is used to differentiate whether the control module has
> > > +   usb mailbox or usb3 phy power. omap4 has usb mailbox in control module to
> > > +   notify events to the musb core and omap5 has usb3 phy power register to
> > > +   power on usb3 phy. Should be "1" if it has mailbox and "2" if it has usb3
> > > +   phy power.
> > 
> > Why not make this a string property, perhaps values "mailbox" or "register"?
> 
> NAK.

Can I ask what your objection to using a string property is?

As far as I can see, "ti,type" is only used by this driver, so there's no
common convention to stick to. Using a string makes the binding easier for
humans to read, and thus harder to mess up in a dts, and it decouples the
binding from kernel-side constants.

Thanks,
Mark.
