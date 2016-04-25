From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 15:37:31 +0100
Message-ID: <20160425143731.GR32731@imgtec.com>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
 <20160425103911.GO32731@imgtec.com>
 <4641918.pNBP5iAK01@wuerfel>
 <20160425125809.GP32731@imgtec.com>
 <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Lee Jones <lee.jones@linaro.org>, Roland Stigge <stigge@antcom.de>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, spear-devel@list.st.com, Ray Jui <rjui@broadcom.com>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Krzysztof Halasa <khalasa@piap.pl>, Gregory Fong <gregory.0xf0@gmail.com>, linux-omap@vger.kernel.org, Paul
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 25, 2016 at 10:12:16AM -0400, Nicolas Pitre wrote:
> Beware.
> 
> I added many of those exactly because gcc did not ignore them when 
> compiling with LTO where the lack of a const qualifier to qualify the 
> actual array content, and not only the reference to that content, 
> generated build errors due to section mismatches from the __initconst 
> annotation.

I believe the first `const` does that, without the need for a second.

> So this is a NAK from me unless you may confirm that LTO builds are 
> unaffected by your changes.

I can't confirm it (haven't tried), and don't care enough to do it :]
I guess I'm just dropping the patch then. Like I said, it can't hurt to
leave them in.

Cheers,
Eric
