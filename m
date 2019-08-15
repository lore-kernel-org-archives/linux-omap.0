From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCHv2] USB: serial: option: Add Motorola modem UARTs
Date: Thu, 15 Aug 2019 13:27:37 +0200
Message-ID: <20190815112737.GD32300@localhost>
References: <20190815082602.51765-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815082602.51765-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Dan Williams <dan.j.williams@intel.com>, Lars Melin <larsm17@gmail.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 15, 2019 at 01:26:02AM -0700, Tony Lindgren wrote:
> On Motorola Mapphone devices such as Droid 4 there are five USB ports
> that do not use the same layout as Gobi 1K/2K/etc devices listed in
> qcserial.c. So we should use qcaux.c or option.c as noted by
> Dan Williams <dan.j.williams@intel.com>.
> 
> As the Motorola USB serial ports have an interrupt endpoint as shown
> with lsusb -v, we should use option.c instead of qcaux.c as pointed out
> by Johan Hovold <johan@kernel.org>.
> 
> The ff/ff/ff interfaces seem to always be UARTs on Motorola devices.
> For the other interfaces, class 0x0a (CDC Data) should not in general
> be added as they are typically part of a multi-interface function as
> noted earlier by Bjørn Mork <bjorn@mork.no>.
> 
> However, looking at the Motorola mapphone kernel code, the mdm6600 0x0a
> class is only used for flashing the modem firmware, and there are no
> other interfaces. So I've added that too with more details below as it
> works just fine.
> 
> The ttyUSB ports on Droid 4 are:
> 
> ttyUSB0 DIAG, CQDM-capable
> ttyUSB1 MUX or NMEA, no response
> ttyUSB2 MUX or NMEA, no response
> ttyUSB3 TCMD
> ttyUSB4 AT-capable

> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lingren <tony@atomide.com>

I fixed up the typo in your name here, which checkpatch caught.

> ---
> 
> Changes since v1:
> - Leave out defines as suggested by Lars

Thanks, Tony. Now applied.

Johan
