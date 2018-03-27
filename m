From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Mon, 26 Mar 2018 17:45:31 -0700
Message-ID: <20180327004531.GH5700@atomide.com>
References: <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
 <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Dan Williams <dcbw@redhat.com> [180326 15:18]:
> On Sun, 2018-03-25 at 13:52 -0700, Tony Lindgren wrote:
> > Anyways, looks like qmi_wwan needs to be loaded before
> > qcserial module, otherwise we get nine ttyUSB instances
> > and ModemManager can't find any modems.
> 
> Use qcaux.c or option, unless the 6600 actually *does* have the same
> layout as Gobi 1K/2K/etc devices.

OK yeah I don't think it's Gobi.

> If you're going to use qcaux or optoin, then you need to use some
> variant of USB_DEVICE_AND_INTERFACE_INFO to lock the serial driver to
> the specific USB interfaces that expose the TTYs and to ignore the QMI
> interfaces and netdevs.

OK thanks I'll take a look and post a patch after some testing.

Regards,

Tony
