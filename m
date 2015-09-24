From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 6/7] gpio: omap: move pm runtime in
 irq_chip.irq_bus_lock/sync_unlock
Date: Thu, 24 Sep 2015 15:35:30 -0700
Message-ID: <56047AB2.80307@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
 <1439896258-26449-7-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbJW6_-yR8CHnK79oEm2c3exUYU-dbKm3YRYe=VVsCMog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbJW6_-yR8CHnK79oEm2c3exUYU-dbKm3YRYe=VVsCMog@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/24/2015 03:28 PM, Linus Walleij wrote:
> On Tue, Aug 18, 2015 at 4:10 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>
>> The PM runtime API can't be used in atomic contex on -RT even if
>> it's configured as irqsafe. As result, below error report can
>> be seen when PM runtime API called from IRQ chip's callbacks
>> irq_startup/irq_shutdown/irq_set_type, because they are
>> protected by RAW spinlock:
>
> Grygorri I have a massive backlog of mail but if patch 6&7 are
> still applicable, can you rebase and send me these for the v4.3-rc2+
> tree?
>

sure.

Thanks.

-- 
regards,
-grygorii
