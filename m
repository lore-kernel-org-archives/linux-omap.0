From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/2] ARM: dts: AM33XX: node definition cleanups
Date: Sat, 10 Aug 2013 19:05:09 +0200
Message-ID: <1376154311-10184-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:55061 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966850Ab3HJRFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Aug 2013 13:05:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

While reviewing the submission of a DT file for a new board
based on the am3352 SoC, I noticed that am33xx*.dts files needed
some cleanups. All am33xx based board files redefine device nodes
that are already defined in the included am33xx.dtsi file.

This not only makes the DTS harder to maintain without any benefit
but also leaks SoC internal details to board files such as how the
OCP interconnect is modeled (currently just a flat representation)
and the addresses of some IP modules that are part of the SoC and
are not going to change from board to board.

This patch-set cleans these board files and is composed of the
following patches:

[PATCH 1/2] ARM: dts: AM33XX: use pinmux node defined in included
[PATCH 2/2] ARM: dts: AM33XX: don't redefine OCP bus and device

NOTE: I don't own any of these am33xx based boards so I was only
able to build test the changes. However I compared the generated
dtb before and after the changes and the disassembled DTS with
dtc -I dtb -O dts foo.dtb > bar.dts are identical.

Even though the binary dtb is the same and there shouldn't be
any visible changes, boot testing will be highly appreciated.

Thanks a lot and best regards,
Javier
