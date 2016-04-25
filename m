From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 11:39:11 +0100
Message-ID: <20160425103911.GO32731@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160425095715.GA2366@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Krzysztof Halasa <khalasa@piap.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Roland Stigge <stigge@antcom.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 25, 2016 at 11:57:15AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> this requires a commit message.

OK? This seems rather pointless in this case (and even more so for the
typo fix I sent yesterday), but I guess you have some general rule to
enforce. Would this do then?
"The second `const` is unnecessary, and is simply ignored by most compilers."

> Also, you should think about separating those changes in multiple patches
> to ease inclusion in the kernel.

I'll resend patch #4 as multiple patches. What the way proper to convey
that *multiple* new patches replace *one* old one? Is it enough to just
send those as a reply to this one?

Cheers
