From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH 0/5] ARM: dts: omap3-gta04: Various updates
Date: Tue, 31 May 2016 08:48:44 +0200
Message-ID: <CAAfyv37NE1eogrSRCuRY-9V30FtD3u7oeFWMJk=xNX1hFJ9O-w@mail.gmail.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux@armlinux.org.uk
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Ping? Any objections? Thanks.

On Tue, May 17, 2016 at 9:48 PM, Marek Belisko <marek@goldelico.com> wrote:
> Add various improvements for gta04 device (wifi, backlight, irq lines for sensors)
>
> H. Nikolaus Schaller (4):
>   ARM: dts: omap3-gta04: Define and use bma180 irq pin
>   ARM: dta: omap3-gta04: Define and use itg3200  irq pin
>   ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
>   ARM: dts: omap3-gat04: Fix wifi handling
>
> Marek Belisko (1):
>   ARM: dts: omap3-gta04: Add backlight support
>
>  arch/arm/boot/dts/omap3-gta04.dtsi | 60 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> --
> 2.5.0
>

Marek

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
