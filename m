From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 16:12:44 -0800
Message-ID: <CAOesGMiniMi9xG6ByL0pQE7wzpM82JB40cPvfJcSYkXPs3PrDw@mail.gmail.com>
References: <52D53084.1070105@ti.com>
	<20140115031632.4167.2698@quantum>
	<20140115035011.4167.96678@quantum>
	<20140115171323.GA22739@atomide.com>
	<20140115192340.4167.87685@quantum>
	<20140115193547.GF7993@atomide.com>
	<20140116213954.4167.37071@quantum>
	<87r486mrh5.fsf@linaro.org>
	<20140117175312.GH7993@atomide.com>
	<52D9723A.6000700@ti.com>
	<20140117205832.4167.95162@quantum>
	<52D9C484.6000404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:37490 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaARAMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 19:12:45 -0500
Received: by mail-qe0-f42.google.com with SMTP id i11so1188352qej.29
        for <linux-omap@vger.kernel.org>; Fri, 17 Jan 2014 16:12:44 -0800 (PST)
In-Reply-To: <52D9C484.6000404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 17, 2014 at 4:02 PM, Nishanth Menon <nm@ti.com> wrote:

> clk-next-6a0cad9 + next-20140117 multi_v7_defconfig + CONFIG_LPAE=y:
>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s21GRhEOj4
>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s20zcNsD8h
>  3: am3517-evm:  Boot PASS: http://slexy.org/raw/s27U9IfRKR
>  4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2zYyeonec
>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21iCRjTHK
>  6: beagleboard-xm:  Boot PASS: http://slexy.org/raw/s20bPGL3Sz
>  7: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21AhFmkCk
>  8:      crane: No Image built - Missing platform support?:
>  9:       dra7:  Boot FAIL: http://slexy.org/raw/s21Qh3sQRu
> * DRA7 not enabled?
> 10:        ldp:  Boot PASS: http://slexy.org/raw/s21fvBfBgs
> 11:   panda-es:  Boot FAIL: http://slexy.org/raw/s20RsgVUZJ
> * known issue (https://patchwork.kernel.org/patch/3084521/)
> 12:    sdp2430:  Boot FAIL: v6 platform - wont boot with multi_v7
> 13:    sdp3430:  Boot PASS: http://slexy.org/raw/s20rhjjBwe
> 14:    sdp4430:  Boot PASS: http://slexy.org/raw/s2My0UfNPm
> 15:       uevm:  Boot PASS: http://slexy.org/raw/s21aqF6eMN
> TOTAL = 15 boards, Booted Boards = 11, No Boot boards = 4


I have a hard time believing the above; A8/A9 boards are not bootable
with CONFIG_LPAE=y...


-Olof
