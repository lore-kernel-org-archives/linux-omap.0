From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 13:38:18 +0200
Message-ID: <4641918.pNBP5iAK01@wuerfel>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com> <20160425095715.GA2366@piout.net> <20160425103911.GO32731@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160425103911.GO32731@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Eric Engestrom <eric.engestrom@imgtec.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Lee Jones <lee.jones@linaro.org>, Roland Stigge <stigge@antcom.de>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, spear-devel@list.st.com, Ray Jui <rjui@broadcom.com>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Krzysztof Halasa <khalasa@piap.pl>, Gregory Fong <gregory.0xf0@gmail.com>, linux-omap@vger.kernel.or
List-Id: linux-omap@vger.kernel.org

On Monday 25 April 2016 11:39:11 Eric Engestrom wrote:
> On Mon, Apr 25, 2016 at 11:57:15AM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > this requires a commit message.
> 
> OK? This seems rather pointless in this case (and even more so for the
> typo fix I sent yesterday), but I guess you have some general rule to
> enforce. Would this do then?
> "The second `const` is unnecessary, and is simply ignored by most compilers."

Maybe say you you found it (llvm, sparse, coccinelle?), and why this
is causing a problem for anyone. If it's just unnecessary but not
harmful, I'd probably ignore the patch.

> > Also, you should think about separating those changes in multiple patches
> > to ease inclusion in the kernel.
> 
> I'll resend patch #4 as multiple patches. What the way proper to convey
> that *multiple* new patches replace *one* old one? Is it enough to just
> send those as a reply to this one?

That's fine. Having multiple patches here is slightly better than just
one, but I'd also be fine with just taking the large patch because it
is an identical trivial change in multiple files.

	Arnd
