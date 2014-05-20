From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/7] mfd: twl4030-power: Add support for board specific
 configuration
Date: Tue, 20 May 2014 16:17:22 +0100
Message-ID: <20140520151722.GA24991@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56646 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaETPR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 11:17:27 -0400
Received: by mail-ie0-f182.google.com with SMTP id as1so598578iec.13
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 08:17:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400031250-29542-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, 13 May 2014, Tony Lindgren wrote:

> With the recommended twl4030 configuration added, we can now add
> board specific changes as modifications to the recommended
> configuration.
>=20
> Note that the data is private to this driver, and the data must
> always have a NULL resource in the sentinel.
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
>  include/linux/i2c/twl.h     |  1 +
>  2 files changed, 22 insertions(+)

Ah, I forgot to Ack this last time, didn't I?

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
