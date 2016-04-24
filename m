From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: qemu:beagle no longer booting with omap2plus_defconfig in -next
Date: Sun, 24 Apr 2016 11:10:25 -0700
Message-ID: <571D0C11.8040609@roeck-us.net>
References: <571BB682.1010806@roeck-us.net>
 <20160423214617.4d0905d2@bbrezillon> <571CF780.1080308@roeck-us.net>
 <20160424191429.48880fdd@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160424191429.48880fdd@bbrezillon>
Sender: linux-next-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On 04/24/2016 10:14 AM, Boris Brezillon wrote:
[ ... ]

>>
>> In qemu, it looks like gpmc bit 0 is considered to be the NAND chip select,
>> which is distinctly different to a chip ready pin.
>
> Well, if you look at the GPIO controller implementation, you'll see
> that gpichip->get() is adding 8 to the GPIO index, so the
> implementation is actually testing bit 8 and not bit 0. Maybe this is
> not emulated properly in qemu though...
>
That helps. The QEMU emulation always returns 0x0001 when reading gpmc register
0x54, which suggests that WAIT0STATUS reports as 0.

>> Guess I would have to try
>> finding a chip datasheet to figure out what this pin is supposed to do, and
>> what is wrong. Since it is somewhat unlikely that I'll find the time to do that,
>> I just disabled MTD_NAND_OMAP2 in my qemu tests instead. Not an ideal solution,
>> of course, but the alternative would be to drop the beagle qemu tests entirely.
>
> Long time I haven't looked at qemu code, but IIRC there were no proper
> support for the NAND layer (maybe this has changed since then though).
> And the R/B pin status emulation is probably much more complicated to
> implement than just returning a valid STATUS byte in a generic NAND chip
> emulation layer (you have to emulate the GPMC block and all its
> external interfaces like the R/B IOs as well as the R/B pin
> emulation at the NAND chip emulation level)...
>

Well enough for it to at least find the NAND chip.

So the qemu "fix" was to return 0x0101 instead of 0x0001 when reading gpmc
register 0x54.

Now I get "INFO: suspicious RCU usage" on reboot, but that is a separate issue.

Thanks a lot for the hints!

Guenter
