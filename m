From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/9] mfd: Drop unnecessary static
Date: Mon, 3 Jul 2017 12:42:29 +0100
Message-ID: <20170703114229.4457nmk627l75nly@dell>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-6-git-send-email-Julia.Lawall@lip6.fr>
 <CAGXu5jKgHObu8Ms4KNsO8g_PkoYp4YZbuHzyz0qPMK5xEkT90w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jKgHObu8Ms4KNsO8g_PkoYp4YZbuHzyz0qPMK5xEkT90w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 27 Jun 2017, Kees Cook wrote:

> On Thu, May 4, 2017 at 1:10 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > Drop static on a local variable, when the variable is initialized before
> > any use, on every possible execution path through the function.
> >
> > The semantic patch that fixes this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @bad exists@
> > position p;
> > identifier x;
> > type T;
> > @@
> >
> > static T x@p;
> > ...
> > x = <+...x...+>
> >
> > @@
> > identifier x;
> > expression e;
> > type T;
> > position p != bad.p;
> > @@
> >
> > -static
> >  T x@p;
> >  ... when != x
> >      when strict
> > ?x = e;
> > // </smpl>
> >
> > The change increases the code size but decreases the size of the bss segment.
> >
> > before:
> >    text    data     bss     dec     hex filename
> >    3369     272     300    3941     f65 drivers/mfd/twl4030-irq.o
> >
> > after:
> >    text    data     bss     dec     hex filename
> >    3401     272      28    3701     e75 drivers/mfd/twl4030-irq.o
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> >  drivers/mfd/twl4030-irq.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> > index b46c0cf..c775f27 100644
> > --- a/drivers/mfd/twl4030-irq.c
> > +++ b/drivers/mfd/twl4030-irq.c
> > @@ -683,7 +683,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
> >
> >  int twl4030_init_irq(struct device *dev, int irq_num)
> >  {
> > -       static struct irq_chip  twl4030_irq_chip;
> > +       struct irq_chip twl4030_irq_chip;
> >         int                     status, i;
> >         int                     irq_base, irq_end, nr_irqs;
> >         struct                  device_node *node = dev->of_node;
> >
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Kernel janitors or Andrew, can you pick this up?

Same.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
