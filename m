From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: Re: [PATCH v3] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Mon, 23 Nov 2009 13:54:22 +0000
Message-ID: <3d374d00911230554w496921dcvb721ebf0cfff9869@mail.gmail.com>
References: <1258924585.10992.1.camel@runt>
	 <20091123132555.GA12983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20091123132555.GA12983@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2009/11/23 Ladislav Michl <Ladislav.Michl@seznam.cz>:

> And sorry to ask again. This very driver works reliable and there are no
> timeouts like this
> mmci-omap mmci-omap.0: command timeout (CMD8)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> while detecting MMC card on OMAP730? (because I can see them on 5910). This question
> is unrelated to your patch.
>

Yes, this driver (after patching) works reliably on OMAP7XX. The
CMD5/8 timeouts seem normal and non-fatal. CMD55 is the "init" command
that has to work. We had an old problem causing output just like what
you report - it turned out we missed a GPIO to power up the MMC card.

-- 
Alistair Buxton
a.j.buxton@gmail.com
