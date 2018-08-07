From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent, not mtd->owner
Date: Tue, 07 Aug 2018 23:55:14 +0200
Message-ID: <5203112.3RHHgWL3HE@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-2-jmkrzyszt@gmail.com> <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <604ff0fb-07d5-9068-2f69-41198f3d9854@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Marek,

On Tuesday, August 7, 2018 1:54:10 AM CEST Marek Vasut wrote:
> On 08/07/2018 12:29 AM, Janusz Krzysztofik wrote:
> > Fix missing mtd->dev.parent assignment and drop useless mtd->owner.
> 
> You fail to explain why this fix is required.

OK, I'll have a look at similar patches from the past and add an explanation.

Thanks,
Janusz
