From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Mon, 1 Jul 2013 11:33:52 +0300
Message-ID: <51D13EF0.6030702@ti.com>
References: <Pine.LNX.4.44L0.1306281507020.1047-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1306281507020.1047-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: balbi@ti.com, tony@atomide.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/28/2013 10:18 PM, Alan Stern wrote:
> On Fri, 28 Jun 2013, Roger Quadros wrote:
> 
>> Just found the problem. It seems that enabling the ehci_irq _after_ the root hub is resumed
>> is the root cause of the problem. Doing so will miss events from the root hub.
> 
> This sounds like a bug in the IRQ setup.  It's the sort of thing you 
> see when a level-triggered IRQ is treated as though it were 
> edge-triggered.
> 
> In any case, the wakeup should have worked whether the IRQ was issued 
> or not.
> 
OK.
> 
> I appreciate the symmetry of putting the enable_irq call in ehci-hcd, 
> seeing as how the disable_irq is there too.  On the other hand, every 
> HCD using this mechanism is going to have to do the same thing, which 
> argues for putting the enable call in the core.  Perhaps at the start 

OK.

> of hcd_resume_work() instead of the end.
> 

We can't enable_irq at the start as the controller will only be resumed
after usb_remote_wakeup().

cheers,
-roger
