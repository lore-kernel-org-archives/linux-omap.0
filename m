From: David Brownell <david-b@pacbell.net>
Subject: Re: FSUSB Port 0 in OMAP2430 SDP
Date: Sun, 19 Aug 2007 15:21:31 -0700
Message-ID: <200708191521.31286.david-b@pacbell.net>
References: <78d6ed630708041237v56338867hd88514c428a56b54@mail.gmail.com>
	<200708181157.19685.david-b@pacbell.net>
	<78d6ed630708181310l2b72418cu6914b29eb760e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630708181310l2b72418cu6914b29eb760e73@mail.gmail.com>
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
> Hi David
> 
> Thanks for the prompt reply.
> 
> I already have ISP-1301 data sheet available with me. Its available
> online at the following link: -
> http://balloonboard.org/hardware/300/ds/ISP1301.pdf
> 
> Now as per the OTG Control Register (address 0x06/0x07), there is an
> ID_PULLDOWN bit and the Vbus_DRV. Now I tried with the following
> instruction: -
> 
> I2Cwrite(0x06,0x30) ;// Setting the Vbus_drv and ID_pulldown
> I2Cread(0x06)
> 
> And when I read back I2Cread(0x06) after the above instruction, I got
> the value as 0x19. So it did not set the Vbus_drv bit. Kindly justify
> this behavior.

Something's not working the way you expect.  :)

Why don't you try reading all the readable registers and making
sure their values make sense.  Are you talking to the isp1301, even?

Maybe your I2Cwrite()/I2Cread() routines are broken... the driver
certainly doesn't have such routines, and neither does Linux.

You *ARE* working in Linux, right?


> >>Undo your muxing of the transceiver linkup pins
> >>as GPIOs.  Make sure they're set up properly (4 wires?  6? etc) and
> >>that the isp1301_omap driver handles that mode.  (ISTR it didn't
> >>handle all possible modes as originally written; no need to.)
> 
> I have found that ISP needs to be configured in three-pin DAT/SE0
> bi-directional mode, so I have done pin/mux configuration for
> Usb0_dat, Usb0_se0 and Usb0_txen. I am not sure whether I need to do
> pin configuration for usb0_puen?

You're missing the point of my suggestion:  make sure that you've
got communication with the transceiver working right, before you
work on getting the OMAP to talk to the transceiver.

If I understand your question, you're asking whether the peripheral
mode's D+ pullup should be handled by OMAP or by the transceiver.

Considering the transceiver has individual control of pullups and
pulldowns on both D+ and D-, and that the hardware is set up to
handle both peripheral and host modes, it should be evident why
the OMAP leaves that issue up to the transceiver...


> This is all that needs to be done at 
> the OMAP done along with the host controller configuration, which is
> already sending the SOF (after configuration like setting OHCI, clock,
> interrupts, syscon registers). I don't need to set any OTG_CTRL
> registers.
> 
> I am not using powered hub, but still in the absence of that I think
> there should be certain interrupt on connection of device.

Like I said, the whole point of my suggestion is to sort out
(first) whether the transceiver setup is working right, apart from
the USB data signaling, and then (second) whether the data signaling
is working right.

So far you haven't done enough of the first part to know whether
it's reasonable to expect such an IRQ.

 
> >>The ID pin is simple:  a Mini-A connector grounds it, a Mini-B one
> >>lets it float.  So it connects to a weak pull-up, and the transceiver
> >>will report its state as either grounded (so the initial OTG state
> >>is A_IDLE and it should enumerate in the host role) or high (so the
> >>initial OTG state is B_IDLE and it should enumerate in peripheral >>role).
> >>There's a bit in one of the OMAP OTG controller registers that reports
> >>the ID pin.  It gets read from the transceiver ... *OR* it can be
> >>forced to either value, if the system doesn't pay attention to OTG
> >>and always runs as host (or as peripheral).
> 
> Mini A and Mini B difference is clear,
> As far as I can understand from the above statement is that role of
> transceiver is just to transmit and receive the signals to the
> host/function controller at the OMAP end, 

"Just" do that?  I don't see how I ever said that.  Even in non-OTG
modes it has to do a lot more than that during connection setup.
Plus there's entry/exit to transceiver lowpower modes...

Your basic problem report is that it doesn't even get to connection
setup.  This indicates that the FIRST problem you need to get past
relates to the transceiver setup.

- Dave


> but rather it does lot more 
> in case of OTG (OTG controller) since it gives info of different
> voltage level changes which makes OTG controller perform intelligent
> decision (like A & B devices State). Kindly confirm.
> 
> Thanks & Regards
> 
> Amit
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
