From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
Date: Mon, 29 Jul 2013 22:30:23 -0600
Message-ID: <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Balaji T K <balajitk@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jon Hunter <jgchunter@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Alexander Holler <holler@ahsoftware.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 29, 2013 at 6:36 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> To solve this dilemma, perform an interrupt consistency check
> when adding a GPIO chip: if the chip is both gpio-controller and
> interrupt-controller, walk all children of the device tree,
> check if these in turn reference the interrupt-controller, and
> if they do, loop over the interrupts used by that child and
> perform gpio_reques() and gpio_direction_input() on these,
> making them unreachable from the GPIO side.

Ugh, that's pretty awful, and it doesn't actually solve the root
problem of the GPIO and IRQ subsystems not cooperating. It's also a
very DT-centric solution even though we're going to see the exact same
issue on ACPI machines.

We have to solve the problem in a better way than that. Rearranging
your patch description, here are some of the points you brought up so
I can comment on them...

> This has the following undesired effects:
>
> - The GPIOlib subsystem is not aware that the line is in use
>   and willingly lets some other consumer perform gpio_request()
>   on it, leading to a complex resource conflict if it occurs.

If a gpio line is being both requested as a gpio and used as an
interrupt line, then either a) it's a bug, or b) the gpio line needs
to be used as input only so it is compatible with irq usage. b) should
be supportable.

> - The GPIO debugfs file claims this GPIO line is "free".

Surely we can fix this. I still don't see a problem of having the
controller request the gpio when it is claimed as an irq if we can get
around the problem of another user performing a /valid/ request on the
same GPIO line. The solution may be to have a special form of request
or flag that allows it to be shared.

> - The line direction of the interrupt GPIO line is not
>   explicitly set as input, even though it is obvious that such
>   a line need to be set up in this way, often making the system
>   depend on boot-on defaults for this kind of settings.

Should also be solvable if the gpio request problem is solved.

g.
