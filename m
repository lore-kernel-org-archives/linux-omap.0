From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: 4.16 OMAP serial transmit corruption?
Date: Mon, 16 Apr 2018 18:48:26 +0100
Message-ID: <20180416174826.GJ10990@n2100.armlinux.org.uk>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416155259.GB5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180416155259.GB5671@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 16, 2018 at 08:52:59AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> > Since this uses a USB adapter (built onto the board) it could be
> > that there could be a bug in the driver for that rather than the
> > OMAP4430 SDP, but I've no way to check that hypothesis.
> 
> Does it go away when you do a warm reboot of the sdp? Then
> it should not be related to the USB iff the ftdi chip is bus
> powered by VBUS.

Yes, the FTDI chip is bus powered.

I booted, ran vi, quit vi, saw corruption, typed reboot, waited for
it to reboot, ran vi, quit vi, and still saw corruption.  So the
reboot seems to have had no effect.

I don't see it with other USB serial consoles on other machines...
I have two of these using the same FTDI chipset:

Bus 001 Device 021: ID 0403:6011 Future Technology Devices International, Ltd FT4232H Quad HS USB-UART/FIFO IC
Bus 001 Device 020: ID 0403:6011 Future Technology Devices International, Ltd FT4232H Quad HS USB-UART/FIFO IC

Device 20 is the SDP board, and device 21 is a ZII board.  Both use
port 2 on the quad ftdi device.  The serial console on the ZII board
is fine, so that seems to rule out the FTDI driver / FTDI hardware.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
