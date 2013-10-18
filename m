From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 1/2] omap board removal for some omap3 boards for v3.13 merge window
Date: Fri, 18 Oct 2013 07:48:47 -0700
Message-ID: <87hacews6o.fsf@linaro.org>
References: <526041db.41abe00a.33b7.00a1SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65232 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab3JROsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 10:48:50 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so4634403pab.39
        for <linux-omap@vger.kernel.org>; Fri, 18 Oct 2013 07:48:49 -0700 (PDT)
In-Reply-To: <526041db.41abe00a.33b7.00a1SMTPIN_ADDED_BROKEN@mx.google.com>
	(Tony Lindgren's message of "Thu, 17 Oct 2013 13:00:21 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit f41509ad0d4c11d0911630440749d409ce2aa1aa:
>
>   Merge branches 'omap-for-v3.13/dt' and 'omap-for-v3.13/quirk' into omap-for-v3.13/board-removal (2013-10-14 11:33:07 -0700)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/board-removal-signed
>
> for you to fetch changes up to f0c09b7c3b4e6b2fe501b3e888797b470de8320c:
>
>   ARM: OMAP2+: Remove legacy support for zoom platforms (2013-10-15 17:38:21 -0700)
>
> ----------------------------------------------------------------
> Changes needed to drop legacy booting support for some
> omap3 boards.
>
> Note that that these are based on a merge of the
> following for the dependencies:
>
> - v3.12-rc5 for fixes to pinctrl mask
> - omap-for-v3.13/dt-signed to avoid pointless merge conflicts
> - omap-for-v3.13/quirk-signed for legacy pdata handling
>
> ----------------------------------------------------------------
> Aaro Koskinen (2):
>       ARM: dts: add minimal DT support for Nokia N950 & N9 phones
>       ARM: OMAP2: delete board-rm680
>
> Tony Lindgren (6):
>       ARM: dts: Shared file for omap GPMC connected smsc911x
>       ARM: dts: Add common support for omap3-evm
>       ARM: dts: Add basic support for TMDSEVM3730 (Mistral AM/DM37x EVM)
>       ARM: dts: Add basic support for zoom3

This patch introduces a build failure when compiling the DTBs:

  [...]
  DTC     arch/arm/boot/dts/omap3-zoom3.dtb
ERROR (phandle_references): Reference to non-existent node or label "wl12xx_gpio"

Kevin

