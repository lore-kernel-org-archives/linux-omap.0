From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH v2 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 15 Apr 2013 09:43:16 -0700
Message-ID: <20130415164316.6507.66311@quantum>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1366032491-4162-6-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59410 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab3DOQnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 12:43:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so2664807pad.30
        for <linux-omap@vger.kernel.org>; Mon, 15 Apr 2013 09:43:21 -0700 (PDT)
In-Reply-To: <1366032491-4162-6-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, linux-omap@vger.kernel.org
Cc: =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

Quoting Andrii Tseglytskyi (2013-04-15 06:28:10)
> Cc: Mike Turquette <mturquette@linaro.org>
> 
> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
> Signed-off-by: Mike Turquette <mturquette@linaro.org>

It is very strange to Cc me and include my Signed-off-by.  Go ahead and
drop my SoB.  I'll review these patches this week but I don't think
implicitly including my SoB is appropriate.

Also why is this limited to LOML?  Cc LKML and Mark Brown (regulator
maintainer) on the next version.  More eyeballs on the code is better.

Finally I also suggest that you rename this patch to:

"regulator: introduce omap abb driver"

As we move stuff out of arch/arm it's important to loop in wider mailing
lists, Cc the appropriate maintainers and title patches more
appropriately.

Regards,
Mike
