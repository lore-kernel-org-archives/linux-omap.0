From: Roger Quadros <rogerq@ti.com>
Subject: Re: gpio: pcf857x: lockdep warning on v4.10-rc3
Date: Wed, 11 Jan 2017 17:55:48 +0200
Message-ID: <4d29c519-f537-df0f-1492-6e46f9d4a03f@ti.com>
References: <48bef841-5267-fcdb-2398-095f6f7ae51e@ti.com>
 <CACRpkdb0KUZabcgAqS1CzWnXt6fyA=CzE9ged1_Ed=+fZB+mqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb0KUZabcgAqS1CzWnXt6fyA=CzE9ged1_Ed=+fZB+mqA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/01/17 17:38, Linus Walleij wrote:
> On Tue, Jan 10, 2017 at 1:18 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
>> Hi Linus,
>>
>> I see the following lockdep warning on v4.10-rc3 on TI's dra7-evm.
>>
>> reverting (d245b3f9bd3 "gpio: simplify adding threaded interrupts") seems to fix it.
> 
> I sent out a patch today:
> "gpio: provide lockdep keys for nested/unnested irqchips"
> 
> could you test and see if it solves your problem?
> 

Yes, it solves the problem for me. Thanks.

cheers,
-roger
