From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] mfd: twl4030-power: Fix hang on reboot if sleep
 configuration was loaded earlier
Date: Tue, 20 May 2014 16:01:19 +0100
Message-ID: <20140520150119.GW24991@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51439 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaETPBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 11:01:24 -0400
Received: by mail-ie0-f171.google.com with SMTP id to1so575924ieb.2
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 08:01:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400031250-29542-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Tue, 13 May 2014, Tony Lindgren wrote:

> Looks like we can still hit the issue of wrong load order of
> twl4030 configuration. If we have a sleep configuration loaded,
> and do a warm reset, the device can hang while initializing the
> wakeup12 sequence. We do have a warning message about wrong order
> of twl4030 configuration, but in this case it does not help as
> the sleep configuration was loaded during the previous boot and
> the state of twl4030 is maintained throughout the warm reset.
>=20
> Fix the issue by clearing any existing sleep configuration
> before we load the warm reset configuration.
>=20
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Can't vouch for the semantics of the patch, but the code looks good.

  Acked-by: Lee Jones <lee.jones@linaro.org>

Can I just apply this, or would you like Peter to review it first?

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
