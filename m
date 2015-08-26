From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Wed, 26 Aug 2015 16:29:52 -0300
Message-ID: <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150825195830.GH27534@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

=46elipe,

On 25 August 2015 at 16:58, Felipe Balbi <balbi@ti.com> wrote:
> Hi Ingo,
>
> I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
> devm_request_*irq().
>

I may be jumping on the gun here, but I believe here's your problem.
Using devm_request_irq with shared IRQs is not a good idea.

Or at least, it forces you to handle interrupts after your device
is _completely_ removed (e.g. your IRQ cookie could be bogus).

AFAICS, the CONFIG_DEBUG_SHIRQ option is just triggering a couple
spurious interrupts, that are expected to happen anyway.

Your IRQ is shared, and so you may get any IRQ at any time,
coming from another device (not yours).

So, if I'm right, my suggestion is simple: use request_irq/free_irq
and free your IRQ before you disable your clocks, remove your device, e=
tc.

> If we using devm_request_*irq(), that irq will be freed after device
> drivers' ->remove() gets called. If on ->remove(), we're calling
> pm_runtime_put_sync(); pm_runtime_disable(), device's clocks might ge=
t
> gated and, because we do an extra call to the device's IRQ handler wh=
en
> CONFIG_DEBUG_SHIRQ=3Dy, we might trigger an abort exception if, insid=
e the
> IRQ handler, we try to read a register which is clocked by the device=
's
> clock.
>
> This is, of course, really old code which has been in tree for many,
> many years. I guess nobody has been running their tests in the setup
> mentioned above (CONFIG_DEBUG_SHIRQ=3Dy, pm_runtime_put_sync() on
> ->remove(), a register read on IRQ handler, and a shared IRQ handler)=
,
> so that's why we never caught this before.
>
> Disabling CONFIG_DEBUG_SHIRQ, of course, makes the problem go away, b=
ut
> if driver *must* be ready to receive, and handle, an IRQ even during
> module removal, I wonder what the IRQ handler should do. We can't, in
> most cases, call pm_runtime_put_sync() from IRQ handler.
>
> I'm guessing the only way would be to move pm_runtime calls into the =
bus
> driver (in this case, the platform_bus) and make sure it only gets
> called after device managed resources are freed ?
>
> Any hints would be greatly appreciated.
>

Hope it helps!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
