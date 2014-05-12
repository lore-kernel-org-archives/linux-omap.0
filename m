From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v5 0/4] add parallel NAND support for TI's new OMAPx and
 AMxx platforms (Part-2)
Date: Mon, 12 May 2014 14:27:12 +0200
Message-ID: <CABxcv=n1xfuNtjQ3fqaeMccGHzCHuGtP0hrtsBMsMWo5oFFLaQ@mail.gmail.com>
References: <1399895353-3663-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:63803 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaELM1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 08:27:13 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so6891520wes.27
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 05:27:12 -0700 (PDT)
In-Reply-To: <1399895353-3663-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

Hello Pekon,

On Mon, May 12, 2014 at 1:49 PM, Pekon Gupta <pekon@ti.com> wrote:
> *changes v4 -> v5*
> use lower-case hexadecimal numbers
> add comments for using different memory sizes in <range> and <reg> properties
> fix 'reg size' property for GPMC and ELM nodes in dra7.dtsi
>
>
> *changes v3 -> v4*
> fixed <reg> and <range> property for all GPMC DT nodes
> added fix for am335x-evm and am437x-epos-evm
> rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap +omap-for-v3.16/dt
>
>
> *changes v2 -> v3*
> rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap :master
> merged leftover patches (dra7-evm and am43x-epos-evm fix) from Part-1 series
>
>
> *changes v1 -> v2*
> [PATCH v2 1/2] created new DTS for memory-capes based on following feedbacks
>   http://www.spinics.net/lists/linux-omap/msg104348.html from 'Nishanth Menon <nm@ti.com>'
>   http://www.spinics.net/lists/linux-omap/msg104447.html from 'Tony Lindgren <tony@atomide.com>'
> [PATCH v2 2/2] <same as [PATCH v1 1/3]>
>
>
> *original v1*
> This patch-set adds parallel NAND support on following TI platforms
>  - AM335x (am335x-bone LT, am335x-boneblack): <disabled by default>
>  - AM43xx (am437x-gp-evm)
>
>
> Minal Shah (1):
>   ARM: dts: dra7: add support for parallel NAND flash
>
> Pekon Gupta (3):
>   ARM: dts: am335x-bone: add support for beaglebone NAND cape
>   ARM: dts: am437x-gp-evm: add support for parallel NAND flash
>   ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
>
>  arch/arm/boot/dts/am335x-bone-memory-cape.dts | 130 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts             |   1 +
>  arch/arm/boot/dts/am335x-boneblack.dts        |   1 +
>  arch/arm/boot/dts/am437x-gp-evm.dts           | 107 +++++++++++++++++++++
>  arch/arm/boot/dts/am43x-epos-evm.dts          |   2 +-
>  arch/arm/boot/dts/dra7-evm.dts                | 117 +++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                   |  20 ++++
>  7 files changed, 377 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/am335x-bone-memory-cape.dts
>

Looks good to me. For the whole series:

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
