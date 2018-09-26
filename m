From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v2] ARM: omap1: add nand_chip declaration
Date: Wed, 26 Sep 2018 17:30:21 +0200
Message-ID: <CAK8P3a29=N9AoBAfKzNR-8fKQgoLGyPJJrqXn0eMwas+nKWN=A@mail.gmail.com>
References: <20180926142029.619397-1-arnd@arndb.de> <20180926165240.77a78fc4@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926165240.77a78fc4@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd <linux-mtd@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Paul Burton <paul.burton@mips.com>, Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 26, 2018 at 4:52 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:
> > @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
> >
> >  extern void __init omap_check_revision(void);
> >
> > +struct nand_chip;
> >  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
> >                              unsigned int ctrl);
> >
>
> Boris pointed me that the commit introducing the regression is still
> in nand/next, so do you mind if I squash both patches with it?

No worries, please do that if it makes it easier for you.

      Arnd
