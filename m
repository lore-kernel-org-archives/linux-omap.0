From: jean-philippe francois <jp.francois@cynove.com>
Subject: [PATCH 0/1] ARM: omap3: Fix regression in dpll4 child clock frequency setting.
Date: Fri, 24 May 2013 09:31:52 +0200
Message-ID: <CAGGh5h2qtc4CdAeupzZBz2OPoqy3h3Tw8__fR1w1PBwd7vFeGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:65515 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab3EXHbx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 May 2013 03:31:53 -0400
Received: by mail-qe0-f49.google.com with SMTP id a11so2401398qen.36
        for <linux-omap@vger.kernel.org>; Fri, 24 May 2013 00:31:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Hi,

The following patch fixes a wrong container_of usage for omap3630.
CAM_MCLK is 216 MHz instead of the asked 172,8 MHz
Any user of this clock is affected. This is the case for instance if
CAM_XCLKA is used to provide clock for an external camera.

All sub clock of dpll4 that do not use a reset value as divider are
also affected.

Beyond wrong frequency setting, this is also a potential oops waiting
to bite any omap3isp user, since a wrong pointer is dereferenced, and
content of this pointer is used to do __raw_writel / __raw_readl.

Regards,
Jean-Philippe Fran=C3=A7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
