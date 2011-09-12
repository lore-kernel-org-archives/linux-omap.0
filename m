From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v4 09/11] OMAP2+: Serial: Use prepare and resume calls to
 gate uart clocks
Date: Mon, 12 Sep 2011 12:07:05 +0530
Message-ID: <CAAL8m4xtrpkWUZYEkcMGdttzwHEC-q72FDcLYLa6hFWjpjQ_0Q@mail.gmail.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
 <1315400013-4849-10-git-send-email-govindraj.raja@ti.com> <87ehzpv8wq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87ehzpv8wq.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 10, 2011 at 12:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Currently we are using uart prepare and resume calls to gate uart clocks
>> retaining the same method.
>>
>> More details on reason to retain this design is provided here:
>> http://www.spinics.net/lists/linux-serial/msg04128.html
>
> This type of thing can go after the '---' since it doesn't belong in the
> permanent git history.
>

Okay.

>> Since prepare and resume hooks are moved to driver itself we can just use
>> a single prepare and resume call. As in driver we traverse on number of uart
>> instance and handle it accordingly.
>
> Some important functionality has been removed (and not documented.)
> Namely, the current code checks the next power when deciding whether or
> not to call prepare_idle, and vice versa for resume_idle.
>
> It's quite possible that it is no longer needed with the runtime PM
>
>> In 34xx uart can wakeup using module level PM_WKEN or IO PAD wakeup use
>> resume_call from prcm irq handler to wakeup uart, based on chk_wakeup_status
>> from io_pad or PM_WKST.
>
> IMO, this patch should just replace the mulitple calls with a single
> call, but still in the idle path.
>

Yes fine, will make resume from prcm_irq a separate patch.

> Using the PRCM IRQ handler should be a separate patch with it's own
> changelog.
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Also, moving these calls to the driver means that the driver cannot be
> built as a module:
>
> arch/arm/mach-omap2/built-in.o: In function `omap2_enter_full_retention':
> /work/kernel/omap/pm/arch/arm/mach-omap2/pm24xx.c:141: undefined reference to `omap_uart_prepare_idle'
> /work/kernel/omap/pm/arch/arm/mach-omap2/pm24xx.c:148: undefined reference to `omap_uart_resume_idle'
> arch/arm/mach-omap2/built-in.o: In function `prcm_clear_mod_irqs':
> /work/kernel/omap/pm/arch/arm/mach-omap2/pm34xx.c:213: undefined reference to `omap_uart_resume_idle'
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> /work/kernel/omap/pm/arch/arm/mach-omap2/pm34xx.c:390: undefined reference to `omap_uart_prepare_idle'
>

Will check and fix this in next version.

--
Thanks,
Govindraj.R
