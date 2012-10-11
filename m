From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and preparation
 for DMA engine conversion
Date: Thu, 11 Oct 2012 09:05:22 -0500
Message-ID: <5076D222.5080600@ti.com>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk> <507427DA.6020409@ti.com> <87mwzuxjtc.fsf@deeprootsystems.com> <507694CF.3020204@ti.com> <20121011095443.GH28061@n2100.arm.linux.org.uk> <50769D8C.8030401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2JKOFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 10:05:34 -0400
In-Reply-To: <50769D8C.8030401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

Hi Sourav,

On 10/11/2012 05:21 AM, Sourav wrote:

[snip]

> I already enable software flow control and did the testing on beagle,
> where things are working fine
> after off mode.
> But if I enable hardware flow control, the teraterm does not allow me to
> load my fs and uImage from mmc.
> If you have any pointers on how to test hardware flow control, I will
> like to do that on my beagle board.

For h/w flow control, you need to check if the CTS and RTS signals are
being brought out to the serial header on the beagle-board. Looking at
the schematics for the 3430 beagle board, it appears that only the UART
RX and TX signals are available on the serial header. Therefore, I don't
believe you can test h/w flow control using the console with that board.

I do see that you can access all the UART2 signals (RX/TX/CTS/RTS) via
the expansion connector on the beagle. However, to connect to a serial
port on a PC you need to have a voltage level-shifter in-between. There
are some companies out there that make them [1], but you need to make
sure you have one that can support a 1.8V input.

Cheers
Jon

[1] http://elinux.org/RS232_Level_Shifter
