From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] irqchip: omap-intc: fix spurious irq handling
Date: Thu, 3 Dec 2015 20:54:45 +0530
Message-ID: <56605EBD.9050001@ti.com>
References: <3d433cfeeb93366cadbb1668ebeac2e8006b0fd5.1445247844.git.nsekhar@ti.com>
 <20151019145039.GA21839@atomide.com> <5625DD9F.6010106@ti.com>
 <876122c7vd.fsf@linutronix.de> <20151020145255.GB3078@atomide.com>
 <56602769.9050708@ti.com> <20151203150222.GH23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151203150222.GH23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 03 December 2015 08:32 PM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar@ti.com> [151203 03:29]:
>> On Tuesday 20 October 2015 08:22 PM, Tony Lindgren wrote:
>>>
>>> OK thanks for testing. My guess from the above list would be EDMA
>>> or CPSW missing a flush of posted write. Maybe try adding a readback
>>> of the related device revision register after acking the interrupt into
>>> TPCC interrupt handler and CPSW interrupt handler(s)?
>>
>> I could get back to debugging this only now. I have converted
>> __raw_writel to writel() and also added readback from the same register
>> in both EDMA and CPSW drivers. But I am still able to reproduce the
>> spurious irq reports.
>>
>>> The timer2 and uart0 seem to be false positives here naturally.
>>
>> I also added readback in 8250 driver. I haven't touched the timer
>> driver, but I guess if that driver had an issue, it should have come out
>> much earlier.
>>
>> I also saw that sometimes previous irq was the TI LCDC interrupt. Added
>> readback there too. Did not help.
> 
> OK strange, so far all the ones we've seen have been fixable that way.
> 
>>> I would not yet rule out the "previous interrupt" theory until you have
>>> tried that. We really want to know the root cause of the issue, just
>>> printing out spurious interrupt does not fix the problem :)
>>
>> While we cannot rule out a software issue completely, the description in
>> TRM around spurious interrupts suggests it can happen even with no role
>> of software.
> 
> Yes maybe we more than one reason for them.
> 
>> May I suggest we go ahead and add this patch to the kernel after
>> addressing Thomas's comment? At least it will prevent kernel from
>> locking up with flood of prints when a spurious irq happens and allows
>> easier debug by others too.
> 
> Yes we should naturally fix up the kernel locking.

Alright. Thanks!

> 
> Please also add something like "enable debug for more information"
> to the warning. And then print out the current and previous interrupt

So I am unconvinced (based on the debug above) that the previous
interrupt information is actually giving any more useful information
than what can be gleaned from observing /proc/interrupts. It seems
previous interrupt noted can be any interrupt you would expect to occur
during the test case anyway.

> if DEBUG is enabled. And in the comments mention that often the spurious
> interrupts has been fixed by adding a flush of the posted write to the
> previous interrupt handler in the device driver.

I can add the comment, no problem.

> Also, do you have a reproducable test case with mainline kernel I
> could add to my collection of shell scripts?

The way I reproduce this is to run the serial port at 3Mbaud in internal
loopback mode with DMA enabled. The test program I use[1] compares the
data sent and received byte-for-byte. With current mainline, that can
mismatch pretty soon. The test will likely end before you see any
spurious irq. There are some patches John Ogness is working on
(currently included in TI's v4.1 kernel) which helps sustain the test
for long and then actually expose the spurious irq issue.

Thanks,
Sekhar

[1] https://git.breakpoint.cc/cgit/bigeasy/serialcheck.git
