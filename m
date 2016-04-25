From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 13:58:09 +0100
Message-ID: <20160425125809.GP32731@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
 <20160425103911.GO32731@imgtec.com>
 <4641918.pNBP5iAK01@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4641918.pNBP5iAK01@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Lee Jones <lee.jones@linaro.org>, Roland Stigge <stigge@antcom.de>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, spear-devel@list.st.com, Ray Jui <rjui@broadcom.com>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Krzysztof Halasa <khalasa@piap.pl>, Gregory Fong <gregory.0xf0@gmail.com>, linux-omap@vger.kernel.o
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 25, 2016 at 01:38:18PM +0200, Arnd Bergmann wrote:
> Maybe say you you found it (llvm, sparse, coccinelle?), and why this
> is causing a problem for anyone. If it's just unnecessary but not
> harmful, I'd probably ignore the patch.

$ grep -rE '(^|\W)const(\s+\w+)+\s+const\s'

I just happened to notice some unnecessary const in our internal code,
so I grep'ed for it in a couple big OSS projects to see how common it
was. Since I found only a few, I decided to remove them, but like I said
it just gets ignored by all the compilers I know, so there's absolutely
no harm in leaving this dead code around.


> That's fine. Having multiple patches here is slightly better than just
> one, but I'd also be fine with just taking the large patch because it
> is an identical trivial change in multiple files.

So, do you want me to split them up? I'd prefer not having to (slightly
less work for me :P), but it doesn't really make much of a difference
either way.

Cheers
