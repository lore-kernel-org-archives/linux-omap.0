From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
Date: Tue, 2 Jul 2013 11:22:17 +0300
Message-ID: <51D28DB9.704@ti.com>
References: <Pine.LNX.4.44L0.1307011655580.1547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <Pine.LNX.4.44L0.1307011655580.1547-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, tony@atomide.com, ruslan.bilovol@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/02/2013 12:01 AM, Alan Stern wrote:
> On Mon, 1 Jul 2013, Felipe Balbi wrote:
> 
>>> I don't know what Pad wakeup is.  The wakeup signal has to originate 
>>> from the EHCI controller, doesn't it?  If not, how does the Pad know 
>>> when a wakeup is needed?
>>
>> That's really an OMAP thing, I guess. Pad wakeup sits in the PRCM (IIRC)
>> inside and always on power domain. EHCI sits in another power domain
>> which be turned off. When it's turned off (power gated and clock gated)
>> the EHCI block has no means to wakeup whatsoever. That's when pad wakeup
>> comes into play. It is generated when PRCM sees a change in the actual
>> pad of the die. To check who should 'own' the wakeup, it checks the
>> muxing settings to verify whose pad is that.
> 
> How does the PRCM know which changes should generate wakeup events?  

It doesn't know. It will always generate a wakeup on any change in the monitored pins.
We can only configure which pins we want to monitor.
So we can't choose which wakeup events we want to monitor. We just can
enable or disable all events.

> In the EHCI controller, this is managed by the settings of the WKOC_E,
> WKDSCNNT_E, and WKCNNT_E bits in the PORTSC registers.  But if EHCI is
> powered off, those bits can't be used.

Is "powered off" same as ehci_suspend? If yes then how does it work on other systems
for remote wakeup?

> 
> Also, once the wakeup signal has been turned on, how does it get turned 
> off again?

That is taken care of by the OMAP pinctrl driver. It will always turn off the
wakeup signal once the event is detected and forwarded as an IRQ.

I know that all this is a bit ugly :(.

cheers,
-roger
