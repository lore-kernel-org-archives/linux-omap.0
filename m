From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
Date: Tue, 07 Aug 2018 19:11:22 +0200
Message-ID: <1593487.Cmi0mten1c@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-6-jmkrzyszt@gmail.com> <20180807190627.4340aade@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807190627.4340aade@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On Tuesday, August 7, 2018 7:06:27 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:11 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Don't readw()/writew() data directly from/to GPIO port which is under
> > control of gpio-omap driver, use GPIO API instead.
> > 
> > Degrade of performance on Amstrad Delta is completely not acceptable.
> 
> Can we have numbers along with information about where the overhead is
> when using gpiod_{get,set}_raw_array_value()?

Yes, as soon as I get physical access to the device, probably this or next 
weekend.

Thanks,
Janusz
