From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data
Date: Tue, 25 Jun 2013 17:18:30 -0700
Message-ID: <87sj05sp0p.fsf@linaro.org>
References: <1372204560-1304-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55505 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3FZASf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 20:18:35 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so13305271pac.26
        for <linux-omap@vger.kernel.org>; Tue, 25 Jun 2013 17:18:34 -0700 (PDT)
In-Reply-To: <1372204560-1304-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 25 Jun 2013 18:56:00 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> commit 20d49e9ccfece526db755940721aa13e331936d4
> (ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data)
>
> Introduced dummy volt data for OMAP5 with OMAP4460 voltage information.
>
> However with the fixes introduced in later patches
>
> commit cd8abed1da91a3250aa4b3857479613a2b446f84
> (ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
>  associated to a pwrdm)
>
> We are no longer restricted in that respect. Further, OPP voltage
> information is supposed to be provided by dts information. This needs
> to be added in future patches as various voltage modules are converted
> to dts.
>
> This also fixes the build breakage for voltagedomains54xx_data.c when just
> OMAP5 SoC is enabled: https://patchwork.kernel.org/patch/2764191/
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org

Acked-by: Kevin Hilman <khilman@linaro.org>

Arnd, to make it easy, below is a pull request for this fix on top of
arm-soc/omap/omap5.

Kevin



The following changes since commit 6503a8e109a639760408f874c1251060d563942e:

  ARM: OMAP5: Remove unused include for ocp2scp (2013-06-09 21:17:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/fixes/omap5-voltdm

for you to fetch changes up to 2ac524f151dbecb862c95b8f433267772caa800e:

  ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data (2013-06-25 17:11:06 -0700)

----------------------------------------------------------------
OMAP5: PM: fix boot by removing unneeded dummy voltage domain data

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data

 arch/arm/mach-omap2/voltagedomains54xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)
