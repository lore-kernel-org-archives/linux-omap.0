From: David Brownell <david-b@pacbell.net>
Subject: Re: FSUSB Port 0 in OAMP2430 SDP
Date: Sat, 18 Aug 2007 11:57:19 -0700
Message-ID: <200708181157.19685.david-b@pacbell.net>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<200708171754.45233.david-b@pacbell.net>
	<78d6ed630708181116u5cd3d93bqe7e1c4b4bcb57ae9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630708181116u5cd3d93bqe7e1c4b4bcb57ae9@mail.gmail.com>
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
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Saturday 18 August 2007, Amit Gupta wrote:

> I have three queries now: -
> 
> 1.	So how it decides to go in the host mode. Do we need to set in
> forcefully by some command before connecting the OMAP to the USB
> device runtime? I have already tried building the code for USB host
> config and then attaching the USB device.

It's complicated.  There are mux settings, OTG controller settings,
isp1301 settings, clocks, and maybe more.  All need to agree.  Start
with Kconfig set up with just OHCI.

Unless 2430 changed more than I'd expect, there will be one mode that
forces all of those settings to say "host".  (I don't have a 2430, so
what I'm telling you is basics and you'll have to work out details.)
It's possible that the full speed USB setup needs 2430 updates... if
for example the modes changed, or new registers got added, etc.  Each
previous generation of OMAPs changed such things, I'd expect this one
is no exception...


One thing that's somewhat straightforward to verify is whether the
isp1301 is configured OK.  You can configure the OMAP side of the
transceiver hookup with all the pins acting as GPIOs, as I recall.
(Simplest to just re-mux all the pins after the usb.c init is done.)
Then use I2C to verify that VBUS output is 5V, and that you get an
isp1301 IRQ when you manually pull up D+ (or even D-) to 3.6V or so.
You should be able to tweak the GPIOs so that the isp1301 chip
drives the J, K, and SE0 states.

Once you know the isp1301 is behaving -- there's no reason the the
host-only setup should have been broken -- the complication is all
on the OMAP side.  Undo your muxing of the transceiver linkup pins
as GPIOs.  Make sure they're set up properly (4 wires?  6? etc) and
that the isp1301_omap driver handles that mode.  (ISTR it didn't
handle all possible modes as originally written; no need to.)


> 2.	Now since you are talking about 8 mA of the current, the USB device
> will never be powered up with only this much current. It can never act
> as host with so less current capability? Even USB mouse requires 100
> mA current. Kindly confirm it.

OTG transceivers are not required to supply more than 8mA of current.
The isp1301 is an OTG transceiver.  I don't recall that it provided
more than the minimum, but check the specs for its charge pump...

Some USB devices work just fine with only 8mA.  Bus-powered ones
will rarely fit in that category.  I generally ended up hooking an
AC-powered hub to the root port, since it didn't draw much power and
would in turn provide up to 500 mA on each downstream port.


> 3.	What is the significance of the ID pin at the transceiver end if
> all the decisions can be taken at the OMAP end and we can configure
> the ISP transceiver accordingly(through I2C). I think the ISP does
> some changes based on the ID pin.

It's been a while since I looked at just what the ISP1301 does, but
I recall that it it didn't do anything "automagically".

The ID pin is simple:  a Mini-A connector grounds it, a Mini-B one
lets it float.  So it connects to a weak pullup, and the transceiver
will report its state as either grounded (so the initial OTG state
is A_IDLE and it should enumerate in the host role) or high (so the
initial OTG state is B_IDLE and it should enumerate in peripheral role).

There's a bit in one of the OMAP OTG controller registers that reports
the ID pin.  It gets read from the transceiver ... *OR* it can be
forced to either value, if the system doesn't pay attention to OTG
and always runs as host (or as peripheral).


> Do we have the ISP1301 programmer's manual, which clearly defines
> programming the transceiver in the transceiver in the host mode/ or in
> the function mode? If possible kindly send it to me.

Go to the supplier's website and download the current spec from there.
A number of your questions would have been answered by that...


> Also, if possible send the config file of the tested code with FSUSB
> port 0 (J51) acted as a host port.

Not possible.  The closest I've got is the kernel.org H2 defconfig;
that's clearly not using a 2430 chip.

- Dave
