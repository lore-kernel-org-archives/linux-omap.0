From: jean-philippe francois <jp.francois@cynove.com>
Subject: [PATCH v2 0/1] ARM: omap3: Fix regression in dpll4 child clock
 frequency setting.
Date: Thu, 30 May 2013 10:49:51 +0200
Message-ID: <CAGGh5h3fjXkmsZDvQVGJ6ehdz7SUghhHcBU-rCcRq_7HQSWN6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:40423 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967252Ab3E3Itx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 04:49:53 -0400
Received: by mail-we0-f176.google.com with SMTP id p58so6875214wes.21
        for <linux-omap@vger.kernel.org>; Thu, 30 May 2013 01:49:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>, paul@pwsan.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

The following patch fixes a wrong container_of usage for omap3630.
All sub clock of dpll4 that do not use a reset value as divider are
affected.

=46or instance CAM_MCLK is 216 MHz instead of the asked 172,8 MHz
Any user of this clock is affected. This is the case for instance if
CAM_XCLKA is used to provide clock for an external camera.

Beyond wrong frequency setting, this is also a potential oops waiting
to bite any omap3isp user, since a wrong pointer is dereferenced, and
content of this pointer is used to do __raw_writel / __raw_readl.

v2 :
=46ollow Mike Turquette's comment and use clock framework instead of
directly accessing register.

Regards,
Jean-Philippe Fran=C3=A7ois
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
