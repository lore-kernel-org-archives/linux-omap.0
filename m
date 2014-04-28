From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: twl4030-power: Add recommended idle
 configuration
Date: Mon, 28 Apr 2014 12:41:33 +0100
Message-ID: <20140428114133.GV21279@lee--X1>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <1398300030-7386-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:39253 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD1Llj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 07:41:39 -0400
Received: by mail-wi0-f179.google.com with SMTP id z2so5479331wiv.12
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 04:41:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398300030-7386-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

> These settings are based on the "Recommended Sleep Sequences for
> the Zoom Platform" pdf at:
>=20
> http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
>=20
> These settings assume most of the regulators are under control of
> Linux, and cuts off VDD1 and VDD2 during off-idle as Linux cannot
> do it.

Linux does it becuase Linux can't do it. Eh?

> For any board specific changes to these, let's patch them in as
> changes to the generic data in the follow-up patches. This keeps
> the board specific changes small.
>=20
> Note that this does not consider the twl5030 errata 27. That
> can be added later on after it has been tested.
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |   4 +
>  drivers/mfd/twl4030-power.c                        | 165 +++++++++++=
++++++++++

driver/mfd changes look good to me:
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
