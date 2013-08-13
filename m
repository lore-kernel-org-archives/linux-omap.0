From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: [PATCH v2] serial: OMAP: add RS485 support
Date: Tue, 13 Aug 2013 11:22:54 +0100
Message-ID: <520A08FE.5070804@newflow.co.uk>
References: <52079822.9020103@newflow.co.uk> <20130812225638.GA30919@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20130812225638.GA30919@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz
List-Id: linux-omap@vger.kernel.org

On 12/08/13 23:56, Greg KH wrote:
> On Sun, Aug 11, 2013 at 02:56:50PM +0100, Mark Jackson wrote:
>> This patch adds RS485 support to the OMAP serial driver, as
>> defined in:-
>>
>> Documentation/devicetree/bindings/serial/rs485.txt
>>
>> When a UART transmitter is connected to (eg) a RS485 driver, it is
>> necessary to turn the driver on/off as quickly as possible.  This is
>> best achieved in the serial driver itself (rather than in userspace
>> where the latency can be quite large).
>>
>> This patch allows a GPIO pin to be defined (via DT) that controls
>> the enabling of the driver at the start of a message, and disables
>> the driver when the message has been completed.
>>
>> When RS485 is disabled, the RTS pin is set to on.
>>
>> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
>> ---
>> Changes in v2:
>> - Fix incorrect logic in serial_omap_config_rs485()
>>
>>  drivers/tty/serial/omap-serial.c |  178 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 178 insertions(+)
> 
> This doesn't apply to my tty-next branch:
> 	checking file drivers/tty/serial/omap-serial.c
> 	Hunk #1 FAILED at 40.
> 	Hunk #2 succeeded at 162 (offset 6 lines).
> 	Hunk #3 succeeded at 280 (offset 5 lines).
> 	Hunk #4 succeeded at 378 (offset 6 lines).
> 	Hunk #5 succeeded at 1312 (offset 8 lines).
> 	Hunk #6 succeeded at 1405 (offset 8 lines).
> 	Hunk #7 succeeded at 1528 (offset 10 lines).
> 	Hunk #8 FAILED at 1638.
> 	Hunk #9 succeeded at 1705 (offset 6 lines).
> 	2 out of 9 hunks FAILED
> 
> so I can't apply it, sorry.

It was applied on top of Linus' tree, if that makes any difference.

I'll rebase onto yours and re-post the patch.
