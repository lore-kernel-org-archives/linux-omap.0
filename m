From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: irqchip: use different lockdep class for each
 gpio irqchip
Date: Mon, 17 Aug 2015 11:06:07 +0200
Message-ID: <CACRpkdbsuxyD1p2miA+Zgern9Fr2pS5PzsUeikViGbfMiP6TgQ@mail.gmail.com>
References: <1439477919-24356-1-git-send-email-grygorii.strashko@ti.com>
	<CACRpkdYtUWc7X5d8mGbZK9dTgKmi1vqYZKK3Ho6mdH5MTE8K8g@mail.gmail.com>
	<55CDE1BB.1060708@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <55CDE1BB.1060708@metafoo.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 14, 2015 at 2:40 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/14/2015 02:34 PM, Linus Walleij wrote:
> [...]
>> Every chip will get their own lock class on the heap.
>>
>> But I think it is a bit kludgy.
>>
>> Is it not possible to have  the lock key in struct gpio_chip
>> be a real member instead of a pointer and get a per-chip
>> lock that way?
>>
>> (...)
>> struct lock_class_key lock_key;
>>
>> instead of:
>>
>> struct lock_class_key  *lock_key;
>>
>> -> problem solved, without kludgy header defines?
>
>
> Lock keys need to be in persistent memory since they have a unlimited life
> time. Once registered it is expected to exist until the system is reset.

Aha I see.

OK if we fix the documentation comment I guess we can go with this,
even if it makes the header file somewhat hard to read.

I have a bit of problem with it, because lockdep instrumentation is
supposed to make development easier, not harder, now it helps
in one end with lock validation and screws up in another end by creating
API headers that are hopeless to read :(

Linus
