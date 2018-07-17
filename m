From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Tue, 17 Jul 2018 22:22:59 +0200
Message-ID: <20180717222259.4145d307@bbrezillon>
References: <20180525222046.11200-1-jmkrzyszt@gmail.com>
        <20180709193850.20191-1-jmkrzyszt@gmail.com>
        <20180717213736.3cd0a747@bbrezillon>
        <1706255.htvcsQMCeE@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1706255.htvcsQMCeE@z50>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 17 Jul 2018 22:20:00 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Hi Boris,
> 
> On Tuesday, July 17, 2018 9:37:36 PM CEST Boris Brezillon wrote:
> > ...
> > Sorry, but we can't apply this patch now because of the dependency on
> > those 2 commits. I guess it's not a big issue if we defer it to 4.20.
> > Alternatively, we could consider queuing it to mtd/fixes after 4.19-rc1
> > is out, but we'll need a good reason to do that (like a regression
> > that this patch is supposed to fix). Note for your future contributions:
> > for this kind of cross-subsystem changes, it's better to let everything
> > go through a single tree (usually done by sending all patches in a
> > single series and explaining the dependencies between the patches in
> > the cover letter),  
> 
> Good advice, Sine I have in my queue a patch for OMAP that depends on this 
> one, and still another one with the same dependency issues, I'll take the path 
> you suggest and resend those three as a series to be merged via OMAP.

Sounds good.
