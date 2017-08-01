From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
Date: Tue, 1 Aug 2017 14:04:26 +0300
Message-ID: <CAHp75VeLwM8Q5vVLeeGz9hL8AWa2J47NTaeX0ogJk6v7y18diw@mail.gmail.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <1499162760.22624.246.camel@linux.intel.com>
 <CACRpkdaxgxaXV8XjLTzu68JqjyeZ8Jr2YMR3L46wm3zmnMrPsg@mail.gmail.com>
 <1501509867.29303.303.camel@linux.intel.com>
 <CACRpkdZ9q5vub3sQkA2xsQaZ+CGHeAp4RRueposnTPiHoFbSsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZ9q5vub3sQkA2xsQaZ+CGHeAp4RRueposnTPiHoFbSsA@mail.gmail.com>
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
Cc: Thor Thayer <thor.thayer@linux.intel.com>, Tien Hock Loh <thloh@altera.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Thierry Reding <thierry.reding@gmail.com>, Alban Bedel <albeu@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Joel Stanley <joel@jms.id.au>, Grygorii Strashko <grygorii.strashko@ti.com>, Ray Jui <rjui@broadcom.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 1, 2017 at 10:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 31, 2017 at 4:04 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Mon, 2017-07-31 at 15:48 +0200, Linus Walleij wrote:
>>> On Tue, Jul 4, 2017 at 12:06 PM, Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:

>>> > If Linus is okay with the following proposal I would rather go with
>>> > it,
>>> > i.e. logical split the series to
>>> >
>>> > 1. Fix IRQ related headers inclusion
>>> > 2. Fix pinconf-generic.h inclusion
>>> > 3. Fix OF headers inclusion (btw, of_gpio.h is not enough there?)
>>>
>>> That works fine with me, but also one big patch actually, I do not
>>> want to make it too much work to refactor obviously incorrect things.
>>>
>>> As soon as we have rough consensus on this and the build robot
>>> are happy I will apply it to GPIO and also pull it into the pinctrl
>>> subsystem.
>>
>> For me priorities like this:
>> 1) it works after the patch being applied (no regressions);
>> 2) it makes code cleaner at the end;
>> 3) it is presented in logically split parts.
>>
>> So, as long as 1) and 2) are satisfied I can neglect on 3).
>
> We are in violent agreement :D

What I would like to say is that is up to you after all :-)
For me looks better to split.

-- 
With Best Regards,
Andy Shevchenko
