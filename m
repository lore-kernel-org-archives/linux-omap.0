From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/14] GPIO: OMAP: first round of cleanup
Date: Thu, 16 Jun 2011 11:16:38 -0700
Message-ID: <877h8lljzt.fsf@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
	<20110527032439.GK5032@ponder.secretlab.ca> <87r56trc8k.fsf@ti.com>
	<20110616162604.GE3795@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110616162604.GE3795@ponder.secretlab.ca> (Grant Likely's
	message of "Thu, 16 Jun 2011 10:26:04 -0600")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Thu, Jun 16, 2011 at 09:07:39AM -0700, Kevin Hilman wrote:
>> Grant Likely <grant.likely@secretlab.ca> writes:
>> 
>> > On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
>> >> Start moving SoC-specific register handling out of the driver by passing
>> >> in register offsets in via platform data.
>> >> 
>> >> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
>> >> 
>> >> Applies on top of Tony's for-next branch (which include's the generic
>> >> IRQ chip work from tglx) and the OMAP GPIO driver move to
>> >> drivers/gpio.
>> >
>> > Hey Kevin,
>> >
>> > If you've got a branch with this series in it and tested, then I'd be
>> > happy to pull that instead of applying the patches myself.
>> >
>> 
>> OK, I rebased this on v3.0-rc2 and now it's been through quite a bit
>> more testing.
>> 
>> Here's a branch for you.
>
> Thanks.  A minor comment though...
>
>> 
>> Also FYI, we'll probably have 2nd round of GPIO cleanups/updates and
>> runtime PM conversion for the upcoming merge window too.
>
> Okay.
>
>> 
>> Kevin
>> 
>> The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:
>> 
>>   Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)
>> 
>> are available in the git repository at:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/gpio-cleanup
>> 
>> Charulatha V (1):
>>       GPIO: OMAP: remove get_gpio_bank()
>> 
>> Kevin Hilman (13):
>>       GPIO: OMAP: _clear_gpio_irqbank: fix flushing of posted write
>>       GPIO: OMAP: remove MPUIO handling from _clear_gpio_irqbank()
>>       GPIO: OMAP: move bank width into struct gpio_bank
>>       GPIO: OMAP: _get_gpio_irqbank_mask: replace hard-coded mask with bank->width
>>       GPIO: OMAP: replace get_gpio_index() by using bank width
>>       GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
>>       GPIO: OMAP: consolidate IRQ status handling, remove #ifdefs
>>       GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
>>       GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
>>       GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
>>       GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
>>       GPIO: OMAP: debounce remove SoC specific registers, use pdata
>>       GPIO: OMAP: cleanup show revision, remove cpu_is checks, display only once
>
> Use this form for the patch summaries please: "gpio/omap: ...."
>
> It's better for the pull req to Linus when all the gpio patches look the same.

heh, every subsystem has it's own conventions.

OK, reworded the shortlogs, re-spun it and re-pushed to the same branch
name.  It might not be to all the mirrors yet, so you might want to pull
using ssh://master.kernel.org/...

The following changes since commit 2c53b436a30867eb6b47dd7bab23ba638d1fb0d2:

  Linux 3.0-rc3 (2011-06-13 15:29:59 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/gpio-cleanup

Charulatha V (1):
      gpio/omap: remove get_gpio_bank()

Kevin Hilman (13):
      gpio/omap: _clear_gpio_irqbank: fix flushing of posted write
      gpio/omap: remove MPUIO handling from _clear_gpio_irqbank()
      gpio/omap: move bank width into struct gpio_bank
      gpio/omap: _get_gpio_irqbank_mask: replace hard-coded mask with bank->width
      gpio/omap: replace get_gpio_index() by using bank width
      gpio/omap: consolidate direction, input, output, remove #ifdefs
      gpio/omap: consolidate IRQ status handling, remove #ifdefs
      gpio/omap: conslidate enable/disable of GPIO IRQs, remove ifdefs
      gpio/omap: convert MPUIO IRQ over to generic irq_chip
      gpio/omap: remove useless gpio_valid() & check_gpio() checks
      gpio/omap: cleanup _set_gpio_wakeup(), remove ifdefs
      gpio/omap: debounce remove SoC specific registers, use pdata
      gpio/omap: cleanup show revision, remove cpu_is checks, display only once

 arch/arm/mach-omap1/gpio15xx.c         |   22 +
 arch/arm/mach-omap1/gpio16xx.c         |   28 ++
 arch/arm/mach-omap1/gpio7xx.c          |   27 ++
 arch/arm/mach-omap2/gpio.c             |   32 ++
 arch/arm/plat-omap/include/plat/gpio.h |   20 +
 drivers/gpio/gpio-omap.c               |  723 +++++++-------------------------
 6 files changed, 282 insertions(+), 570 deletions(-)
