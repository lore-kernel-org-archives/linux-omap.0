From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: qemu:beagle no longer booting with omap2plus_defconfig in -next
Date: Sun, 24 Apr 2016 11:11:49 -0700
Message-ID: <571D0C65.1020500@roeck-us.net>
References: <571BB682.1010806@roeck-us.net>
 <20160423214617.4d0905d2@bbrezillon> <571CF780.1080308@roeck-us.net>
 <20160424193414.2bc82d47@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160424193414.2bc82d47@bbrezillon>
Sender: linux-next-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/24/2016 10:34 AM, Boris Brezillon wrote:
> On Sun, 24 Apr 2016 09:42:40 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> In qemu, it looks like gpmc bit 0 is considered to be the NAND chip select,
>> which is distinctly different to a chip ready pin. Guess I would have to try
>> finding a chip datasheet to figure out what this pin is supposed to do, and
>> what is wrong. Since it is somewhat unlikely that I'll find the time to do that,
>> I just disabled MTD_NAND_OMAP2 in my qemu tests instead. Not an ideal solution,
>> of course, but the alternative would be to drop the beagle qemu tests entirely.
>
> Here is a patch [1] which should fix your problem. It's obviously not
> enough to handle the different use cases we have in in the wild, but
> should fix your problem on the beagle board.
>
> Regards,
>
> Boris
>
> [1]http://code.bulix.org/i5c4yc-97598
>
Yep, I figured out that one a minute ago :-)

Thanks again!

Guenter
