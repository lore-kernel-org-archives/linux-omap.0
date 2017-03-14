From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/12] gpio: xlp: use resource management for irqs
Date: Tue, 14 Mar 2017 16:11:51 +0100
Message-ID: <CACRpkdarjWkQJgS8x6N3MW72XXB1fsN-72nDCX_qdPi5TuSyOQ@mail.gmail.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com> <1488644620-11488-7-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-7-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 4, 2017 at 5:23 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> Use the resource managed variant of irq_alloc_descs() and remove the
> code manually freeing allocated interrupt descriptors.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied.

Yours,
Linus Walleij
