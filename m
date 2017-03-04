From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 07/12] gpio: pxa: use devm_irq_alloc_descs()
Date: Sat, 04 Mar 2017 21:31:20 +0100
Message-ID: <87fuiswzqf.fsf@belgarion.home>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
        <1488644620-11488-8-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-8-git-send-email-bgolaszewski@baylibre.com>
        (Bartosz Golaszewski's message of "Sat, 4 Mar 2017 17:23:35 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> This driver never frees the interrupt descriptors it allocates. Fix
> it by using the resource managed version of irq_alloc_descs().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
