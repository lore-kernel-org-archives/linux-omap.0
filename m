From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v5 DTS 0/4] Fix AM335x-evm analog audio support
Date: Sun, 20 Oct 2013 19:14:30 +0200
Message-ID: <52640F76.7060208@baylibre.com>
References: <52615C70.30307@baylibre.com> <cover.1382288454.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35644 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JTROe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Oct 2013 13:14:34 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so2985279wib.5
        for <linux-omap@vger.kernel.org>; Sun, 20 Oct 2013 10:14:33 -0700 (PDT)
In-Reply-To: <cover.1382288454.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com

Hi Jyri,

On 20/10/2013 19:04, Jyri Sarha wrote:
> Hi Benoit,
> I rebased the DTS patches on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.=
git
> for_3.13/dts -branch
> and tested the result. Hope that was the right branch.

Yes, thanks for the update.

I've just applied the patches.

Regards,
Benoit

>
> The DTS patches can also be pulled from:
> git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-li=
nux-feature-tree.git
> for_bcousson/for_3.13/dts -branch
>
> The non DTS patches rebased on top of v3.12-rc5 can be pulled from he=
re:
> git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-li=
nux-feature-tree.git
> v3.12-rc5-am33xx-audio-patch-v5-no-dts -branch
>
> The the full patch series can be found here:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067=
443.html
>
> Best regards,
> Jyri
>
> Darren Etheridge (1):
>    ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
>
> Jyri Sarha (1):
>    ARM/dts: am33xx: mcasp: Add location for data port registers to
>      reg-property
>
> Pantelis Antoniou (1):
>    ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries
>
> Peter Ujfalusi (1):
>    ARM/dts: am335x-evmsk: Audio support
>
>   arch/arm/boot/dts/am335x-evm.dts   |   50 +++++++++++++++++++++++++=
+++++++++++
>   arch/arm/boot/dts/am335x-evmsk.dts |   48 +++++++++++++++++++++++++=
+++++++++
>   arch/arm/boot/dts/am33xx.dtsi      |   28 ++++++++++++++++++++
>   3 files changed, 126 insertions(+)
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
