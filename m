From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
Date: Wed, 16 Jul 2014 18:40:01 +0200
Message-ID: <53C6AAE1.7090802@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
 <20140716151604.GG1365@saruman.home> <53C6A050.2050409@linutronix.de>
 <20140716160614.GI1365@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140716160614.GI1365@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2014 06:06 PM, Felipe Balbi wrote:

>>> well, other than in probe and other functions which need to
>>> make sure clocks are on, but it seems unnecessary to
>>> enable/disable in every function.
>> 
>> What do you have in mind? Do you plan to let the uart on while
>> the minicom is attached but is doing nothing? In that case,
>> ->startup() and ->shutdown() should be enough.
> 
> no the idea was to keep it on for as long as it's transferring 
> characters and idle it otherwise, if that can't be done easily,
> then I guess your way is the only way.

But maybe we have to add some additional logic here to keep it up for
the transfer. I've been just (maybe over)thinking: If you send 300
bytes over DMA via 300 baud it should take 10 seconds. The PM-timeout
could hit before the transfer is complete.
Same thing with hw-flowcontrol where you could get stalled for a few
seconds.
However it doesn't seem to be a problem in current omap-serial driver.

> cheers

Sebastian
