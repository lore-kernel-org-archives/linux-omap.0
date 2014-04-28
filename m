From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] mfd: twl4030power: Add a configuration to turn off
 oscillator during off-idle
Date: Mon, 28 Apr 2014 12:48:56 +0100
Message-ID: <20140428114856.GX21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:42577 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD1LtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 07:49:03 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so5518837wiv.10
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 04:49:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398300030-7386-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

> Some oscillators can be turned off during off-idle saving few
> a little bit power at the cost of the oscillator start up
> latency.
>=20
> If you board can do this, you can now enable it by using the
> ti,twl4030-power-idle-osc-off compatible flag.
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt         |  6 ++++++
>  drivers/mfd/twl4030-power.c                           | 19 +++++++++=
++++++++++

Code in drivers/mfd looks scruffy but fine:
  Acked-by: Lee Jones <lee.jones@linaro.org>


--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
