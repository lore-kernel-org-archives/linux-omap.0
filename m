From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
Date: Tue, 07 Aug 2018 19:15:24 +0200
Message-ID: <1630565.P2WKYxFjuh@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-9-jmkrzyszt@gmail.com> <20180807190256.092b2364@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807190256.092b2364@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, August 7, 2018 7:02:56 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:14 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Simplify data read/write sub-functions by changing their APIs so they
> > accept driver private structure pointer instead of mtd_info.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Can you move that one earlier in the series so that it can be applied
> even if we're still discussing the GPIO bitmap changes?

Sure, I will, and I would be still more happy if you agreed on me doing the 
same with [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction 
once per transfer.

Thanks,
Janusz
