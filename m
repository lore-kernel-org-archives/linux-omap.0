From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and
	preparation for DMA engine conversion
Date: Thu, 11 Oct 2012 12:08:48 +0100
Message-ID: <20121011110848.GI28061@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk> <507427DA.6020409@ti.com> <87mwzuxjtc.fsf@deeprootsystems.com> <507694CF.3020204@ti.com> <20121011095443.GH28061@n2100.arm.linux.org.uk> <50769D8C.8030401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50769D8C.8030401@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 11, 2012 at 03:51:00PM +0530, Sourav wrote:
> True. I missed that point while doing the testing. Sorry for that.
> I further looked into it and saw some two options  in my minicom  
> settings(Hardware Flow Control/ Software Flow Control) Which I am  
> thinking are the ones used to enable the flow control ? and they are  
> both set to NO.
>
> I already enable software flow control and did the testing on beagle,  
> where things are working fine
> after off mode.
> But if I enable hardware flow control, the teraterm does not allow me to  
> load my fs and uImage from mmc.
> If you have any pointers on how to test hardware flow control, I will  
> like to do that on my beagle board.

Okay, it sounds like I need to do a teach-in on flow control...

First, hardware flow control.  Hardware flow control is operated by two
signals: RTS and CTS.

In conventional setups, CTS is an input to the transmitter, and controls
whether the transmitter may start the transmission of a new character.
If CTS is deasserted, the transmitter will stop after the completion of
the previous character.  When hardware flow control is disabled, the
transmitter ignores this signal.

RTS is an output, and is generally used to control the remote transmitter.
(There are setups where RTS means something else, but the kernel doesn't
support other schemes directly.)  RTS is asserted when either hardware
flow control is disabled, or there is sufficient space to receive more
characters from the remote end.

This is a symetrical setup, so that two UARTs connected together using
this scheme will have the RTS of one connected to the CTS of the other.
This way, each can signal whether characters should be transmitted.

So, in minicom, when hardware flow control is disabled, your hosts
transmitter will ignore the state of the CTS signal, and will hold its
RTS asserted.

If hardware flow control in minicom is enabled, then that tells the
kernel (and possibly hardware) to take note of the CTS signal, and pause
transmission when CTS is deasserted.  It will also cause the RTS signal
to be manipulated according to available buffer space on the receive
side.

Obviously minicom will try to ensure that any characters received are
displayed as quickly as possible, so it's unlikely that the receive side
will fill up.

When you're logged into a system via a serial line, the hardware flow
control state is controlled by the CRTSCTS termios flag.  That can be
seen and manipulated by stty.  stty -a to see all flags.  stty -crtscts
to disable, stty crtscts to enable.


Now, for software flow control.  It operates in the same way as above,
but instead of a hardware signal reporting the state, characters are
embedded into the stream.

In normal situations, these characters are the standard ^Q (noramlly XON)
and ^S (XOFF) characters.  You'll find that works in gnome-terminals,
xterms, and many places because it's part of the standard terminal
interface.  You can type these characters into minicom with or without
software flow control disabled; it just passes them through unmodified.

When software flow control is enabled, and the tty receive buffers start
to fill up, the kernel will queue a high-priority XOFF character for the
UART to transmit to the remote end.  Once the tty buffers have emptied
sufficiently, it will queue a high-priority XON character.  If software
flow control is disabled, it will ignore this.

When hardware assisted software flow control is enabled, this will be
done by the hardware itself in response to the UART FIFO filling up and
emptying.

For the target, software flow control has more configuration options:

	ixon: controls whether the transmitter starts/stops on reception
		of xon/xoff characters
	ixoff: controls the generation of xon/xoff characters
	ixany: permits any received character (including xon) to restart
		transmission
	stop <char>: sets the xoff character to the specified character
	start <char>: sets the xon character to the specified character

xon and xoff default to ^Q and ^S respectively, there's no need to
'initialize' them prior to use.  So, to enable software flow control
(which is probably already enabled on the target):

	stty ixon ixoff

and then you can type ^S and ^Q into minicom to stop/start the target's
transmit output.

Finally, to make the target's input buffer fill up, arrange for the
target not to read from the controlling tty at all.  sleep 120 will
do that for two minutes, after which the input will be gobbled up by
the shell (which it'll try to interpret as commands.)  So, probably
better to do:

	sleep 120; echo Finished; cat >/dev/null

instead, and then send lots of data, and check whether the transmission
stops, whether the right xon/xoff characters are transmitted, and whether
any overrun errors are reported.

Going the other way, you can suspend minicom (^a z) and then arrange for
the target to send lots of data, and again check what happens.

There's a gotcha there though: with standard 8250-based serial ports,
we have /proc/tty/driver/serial which gives easy access to the port
statistics.  With USB stuff, those statistics are not available, so it
becomes much harder to test.  You have to arrange for the target to send
a known pattern, and find some way to check at the host end that it was
correctly received, including over the flow control events.

No characters should be lost when flow control is being used; after
all, that's the whole point of the facility.
