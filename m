From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCHv3 0/2] ARM: dts: Add initial support for IGEP AQUILA
Date: Wed, 25 Sep 2013 15:10:21 +0200
Message-ID: <CAAwP0s2NOswrZPdeM7GG2J3e+2JeQSKUpX3cki+CbF9G4KyTpA@mail.gmail.com>
References: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35004 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab3IYNKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 09:10:42 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so10929613ief.3
        for <linux-omap@vger.kernel.org>; Wed, 25 Sep 2013 06:10:41 -0700 (PDT)
In-Reply-To: <1378824949-18792-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Tue, Sep 10, 2013 at 4:55 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
>
> Hi all,
>
> These two patches introduces initial support for the IGEP AM335x-based
> platforms. The first patch add support for IGEP COM AQUILA products, and the
> second patch add support for the development board.
>
> These patches apply on top of bcousson/for_3.12/dts repository.
>
> Changes since v2:
>   * Make it compatible with "isee,am335x-base0033", "isee,am335x-igep0033",
>     "ti,am33xx" since these boards are manufactured by ISEE not TI. (Javier)
> Changes since v1:
>   * Use &node to reference the nodes already defined in dtsi files. (Javier)
>
> Best regards,
>
> Enric Balletbo i Serra (2):
>   ARM: dts: AM33XX: Add support for IGEP COM AQUILA
>   ARM: dts: AM33XX: Add support for IGEP AQUILA EXPANSION board.
>
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/am335x-base0033.dts  |  16 ++
>  arch/arm/boot/dts/am335x-igep0033.dtsi | 265 +++++++++++++++++++++++++++++++++
>  3 files changed, 282 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-base0033.dts
>  create mode 100644 arch/arm/boot/dts/am335x-igep0033.dtsi
>
> --
> 1.8.1.2
>

Hi Benoit and Tony,

Any comments on this series? I had already reviewed previous versions
of the DT and it looks good to me now.

It would be great if this can make it for 3.13.

Thanks a lot and best regards,
Javier
