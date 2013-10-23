From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap5-uevm: Audio related fixes
Date: Wed, 23 Oct 2013 11:38:42 +0200
Message-ID: <52679922.1050004@baylibre.com>
References: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:36556 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3JWJiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 05:38:46 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so184762bkb.2
        for <linux-omap@vger.kernel.org>; Wed, 23 Oct 2013 02:38:44 -0700 (PDT)
In-Reply-To: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

On 23/10/2013 11:32, Peter Ujfalusi wrote:
> Hi,
>
> When the omap5-evm.dts file has been renamed to omap5-uevm.dts and th=
e sEVM
> support got deprecated in favor of uEVM (or Panda5) the content was n=
ot
> validated.
> The reset GPIO is different on uEVM compared to sEVM and uEVM does no=
t have
> support for dmic.
>
> Regards,
> Peter

I've just applied your series, let's try to push that for 3.13.

Thanks,
Benoit


> ---
> Peter Ujfalusi (2):
>    ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
>    ARM: dts: omap5-uevm: Remove pinmux for dmic pins
>
>   arch/arm/boot/dts/omap5-uevm.dts | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
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
