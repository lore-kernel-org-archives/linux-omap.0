From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Date: Wed, 5 Dec 2018 11:35:35 +0000
Message-ID: <20181205113535.GX16508@imbe.wolfsonmicro.main>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Cory Maccarrone <darkstar6262@gmail.com>, David Dajun Chen <dchen@diasemi.com>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Miao <eric.miao@marvell.com>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Mike Rapoport <mike@compulab.co.il>, Tony Lindgren <tony@atomid>
List-Id: linux-omap@vger.kernel.org

On Sun, Dec 02, 2018 at 11:23:07PM -0500, Paul Gortmaker wrote:
> The solution to #4 is similar - we delete the ".remove" function and
> the binding into the platform_driver struct.  However, since the same
> ".remove" function could also be triggered by an "unbind" (such as for
> pass-through of a device to a guest instance)  - so we also explicitly
> disable any unbind for the driver.
> 
> The unbind mask allows us to ensure we will see if there was some odd
> corner case out there that was relying on it.  Typically it would be a
> multi-port ethernet card passing a port through to a guest, so a
> sensible use case in MFD drivers seems highly unlikely.  This same
> solution has already been used in multiple other mainline subsystems.
> 

I guess if this is a general direction thing, but it does seem
that module unload is not the only reason one might ever unbind a
driver. So are we sure we want to remove the option to unbind
these drivers? Certainly for testing it is sometimes useful.

Thanks,
Charles
