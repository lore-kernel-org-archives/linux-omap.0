From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
Date: Fri, 1 Jun 2012 05:13:18 -0500
Message-ID: <CAOMWX4dPQGw=_u5HvD8T9cJ1aSo8tTsmok+bj2Op5TWtbp9R4A@mail.gmail.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com> <1338470942-20185-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:54781 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759379Ab2FAKNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 06:13:41 -0400
Received: by wibhn14 with SMTP id hn14so402544wib.11
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 03:13:38 -0700 (PDT)
In-Reply-To: <1338470942-20185-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, May 31, 2012 at 8:28 AM, Tero Kristo <t-kristo@ti.com> wrote:
minor comment:
> +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
<snip>
> +void pwrdm_clkdm_disable(struct powerdomain *pwrdm)

I know the understand that rest of the code lacks kernel-doc, but at
least can we ensure that the new functions does?

Regards,
Nishanth Menon
