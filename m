From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 5/5] Input: Add tps65217 power button driver
Date: Tue, 21 Jun 2016 08:17:35 -0500
Message-ID: <20160621131735.GA896@rob-hp-laptop>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-6-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160620105056.25843-6-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 20, 2016 at 12:50:56PM +0200, Marcin Niestroj wrote:
> This driver enables us to use tps65217's power button as KEY_POWER on
> am335x boards (directly connected button in chiliboard, accessible pin
> via expansion header in beaglebone). This patch has been tested with
> chiliboard.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Depends on patches 1-4 in series
> 
> Changes v2 -> v4: none
> 
> Changes v1 -> v2:
>  * Added information about parent device in tps65217 power button
>    device-tree binding documentation (suggested by Rob)
> 
>  .../bindings/input/tps65217-pwrbutton.txt          |  17 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/misc/Kconfig                         |  10 ++
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++++++++++
>  4 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>  create mode 100644 drivers/input/misc/tps65217-pwrbutton.c
