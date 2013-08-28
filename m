From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5] gpio: pcf857x: Add OF support
Date: Wed, 28 Aug 2013 13:58:13 +0200
Message-ID: <7583101.2yAsZLOucV@avalon>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2400176.9Vcd5TUYl9@avalon> <20130827171854.GA2988@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130827171854.GA2988@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <t.figa@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-gpio@vger.kernel.org, Archit Taneja <archit@ti.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 August 2013 19:18:55 Wolfram Sang wrote:
> > The driver should support the same chip models reardless of whether it's
> > used with or without DT. If an entry in the OF table has no corresponding
> > entry in the I2C table I would consider that as a driver bug.
> 
> Linus Walleij posted a patch to support DT only probing, but too many
> side-effects showed up. Some were fixable (probe regressions) and some
> need more work, if feasible at all. Most prominent is that runtime
> instantiation of i2c slaves currently needs an entry in the i2c table.

Linus, I'd like to get this in v3.12 if it's not too late. Could you please 
provide your input ?

-- 
Regards,

Laurent Pinchart
