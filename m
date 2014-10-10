From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH 0/3] input: tsc2007: Extend for pre-calibration, flipping
 and rotation
Date: Fri, 10 Oct 2014 11:28:51 +0200
Message-ID: <CAAfyv36R-qpQPLHGGv8+QPtwyRWRJc4rPi9GcNwWpuCTGmWuWQ@mail.gmail.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1412108254-19234-1-git-send-email-marek@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Ping. Any objections? Thanks

On Tue, Sep 30, 2014 at 10:17 PM, Marek Belisko <marek@goldelico.com> wrote:
> Following series add support to tsc2007 touchscreen driver for pre-calibration,
> flipping and rotation. Added bindings are documented and used in gta04 device tree.
>
> Marek Belisko (3):
>   input: tsc2007: Add pre-calibration, flipping and rotation
>   Documentation: dt: input: tsc2007: Document new parameters
>   arm: dts: omap3-gta04: Extend touchscreen configs
>
>  .../bindings/input/touchscreen/tsc2007.txt         | 17 ++++-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 |  6 ++
>  drivers/input/touchscreen/tsc2007.c                | 89 +++++++++++++++++++++-
>  include/linux/i2c/tsc2007.h                        |  6 ++
>  4 files changed, 111 insertions(+), 7 deletions(-)
>
> --
> 1.9.3
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
