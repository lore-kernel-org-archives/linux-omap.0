From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv3 0/4] Add device tree data for omap5
Date: Mon, 20 Aug 2012 17:40:29 +0530
Message-ID: <CAKdam57L8txFtE9ahy3u3vLW0XRP5z4QaNQKVFj9KaEFZE1qvg@mail.gmail.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47177 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752015Ab2HTMKa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 08:10:30 -0400
Received: by vcdd16 with SMTP id d16so6675065vcd.30
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 05:10:29 -0700 (PDT)
In-Reply-To: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi All,

On Tue, Aug 14, 2012 at 9:54 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:
> The following patch series add i2c support for omap5.
> As well as enable I2C based devices like pressure and temperature
> through device tree. Also add onchip keypad dts data.
>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Sourav Poddar (4):
>   arm/dts: omap5-evm: Add I2C support
>   arm/dts: omap5-evm: Add tmp102 sensor support
>   arm/dts: omap5-evm: Add keypad data
>   arm/dts: omap5-evm: Add bmp085 sensor support
>
> v2->v3
> - Rebased on 3.6-rc1
> - Add comments for tmp102 and bmp085
>  arch/arm/boot/dts/omap5-evm.dts |   32 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 0 deletions(-)
>
Any comment on this series?

~Sourav
