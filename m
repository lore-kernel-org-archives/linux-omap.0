From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Tue, 26 Apr 2016 12:12:46 +0200
Message-ID: <m337q8fzkx.fsf@t19.piap.pl>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
	<20160425095715.GA2366@piout.net> <20160425103911.GO32731@imgtec.com>
	<4641918.pNBP5iAK01@wuerfel> <20160425125809.GP32731@imgtec.com>
	<alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
	<20160425143731.GR32731@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160425143731.GR32731@imgtec.com> (Eric Engestrom's message of
	"Mon, 25 Apr 2016 15:37:31 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Lee Jones <lee.jones@linaro.org>, Roland Stigge <stigge@antcom.de>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, spear-devel@list.st.com, Ray Jui <rjui@broadcom.com>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Eric Engestrom <eric.engestrom@imgtec.com> writes:

> I can't confirm it (haven't tried), and don't care enough to do it :]
> I guess I'm just dropping the patch then. Like I said, it can't hurt to
> leave them in.

Actually it may hurt (a little bit) - it makes the code less readable.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
