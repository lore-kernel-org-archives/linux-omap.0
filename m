From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] gpiolib: irqchip: use different lockdep class for each
 gpio irqchip
Date: Fri, 14 Aug 2015 14:40:27 +0200
Message-ID: <55CDE1BB.1060708@metafoo.de>
References: <1439477919-24356-1-git-send-email-grygorii.strashko@ti.com> <CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/14/2015 02:34 PM, Linus Walleij wrote:
[...]
> Every chip will get their own lock class on the heap.
> 
> But I think it is a bit kludgy.
> 
> Is it not possible to have  the lock key in struct gpio_chip
> be a real member instead of a pointer and get a per-chip
> lock that way?
> 
> (...)
> struct lock_class_key lock_key;
> 
> instead of:
> 
> struct lock_class_key  *lock_key;
> 
> -> problem solved, without kludgy header defines?


Lock keys need to be in persistent memory since they have a unlimited life
time. Once registered it is expected to exist until the system is reset.

We recently fixed the same issue of nested locks in regmap. For reference
the discussion with had a look at different ways to solve this can be found
here[1] and the final patch series that went in here[2].

- Lars

[1] https://lkml.org/lkml/2015/6/25/144
[2] https://lkml.org/lkml/2015/7/8/43

