From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] arm: omap: Immutable branch between MFD and ARM OMAP due
 for the v3.16 merge-window
Date: Wed, 23 Apr 2014 15:46:44 +0100
Message-ID: <20140423144644.GF6264@lee--X1>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
 <20140417080051.GE28725@lee--X1>
 <20140417153722.GA23385@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46369 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaDWOqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:46:51 -0400
Received: by mail-wi0-f176.google.com with SMTP id r20so5025426wiv.9
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 07:46:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140417153722.GA23385@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Hi Tony,

Sorry for the delay - I've been snowed under recently.

As requested, you patch based on v3.14 ( for some reason :) ).

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73d=
e11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-omap-3.16

for you to fetch changes up to a613b739b8c08eab811e677810045cc0522fc3e6=
:

  mfd: twl-core: Fix idle mode signaling for omaps when booted with dev=
ice tree (2014-04-23 15:31:05 +0100)

----------------------------------------------------------------
Immutable branch between MFD and ARM OMAP due for v3.16 merge-window.

----------------------------------------------------------------
Tony Lindgren (1):
      mfd: twl-core: Fix idle mode signaling for omaps when booted with=
 device tree

 arch/arm/mach-omap2/omap_twl.c | 60 ----------------------------------=
--------------------------
 drivers/mfd/twl-core.c         | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 60 deletions(-)

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
