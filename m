From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] ARM: omap2+: set IRQCHIP_SKIP_SET_WAKE for INTC interrupts.
Date: Fri, 27 Apr 2012 15:01:52 -0700
Message-ID: <8762ckzve7.fsf@ti.com>
References: <20120425025637.7832.14013.stgit@notabene.brown>
	<20120425030524.7832.52047.stgit@notabene.brown>
	<878vhi9qj8.fsf@ti.com> <20120427065040.3ba0fce2@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120427065040.3ba0fce2@notabene.brown> (NeilBrown's message of
	"Fri, 27 Apr 2012 06:50:40 +1000")
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> On Thu, 26 Apr 2012 13:39:07 -0700 Kevin Hilman <khilman@ti.com> wrote:
>
>> NeilBrown <neilb@suse.de> writes:
>> 
>> > All interrupts can wake-from-sleep (I think) so it should be
>> > permissible to call enable_irq_wake().  Setting this flag allows that.
>> >
>> > It is needed because without this, an interrupt which is delivered
>> > during late suspend will get ignored but will not cause suspend to
>> > abort.
>> > If enable_irq_wake() is called and succeeds, check_wakuep_irqs()
>> > will abort the suspend if the interrupt has fired.
>> >
>> > Signed-off-by: NeilBrown <neilb@suse.de>
>> 
>> The name of this flag and the effect of setting it are somewhat
>> confusing (e.g. why does skipping set_wake suddenly make wakeups work.)
>> So I tried to make it clearer with a reworking of the changelog (below.)
>> 
>> If I understood this correctly, and if you're OK with the updated
>> changelog, I'll queue this up for v3.5.
>> 
>
> I'm very OK with your updated changelog - thanks.  Filling in various bits
> that I didn't know and clarifies the rest :-)

Great, thanks.

Adding ack from Santosh (thanks!) and queuing for v3.5[1]

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/pm-misc
