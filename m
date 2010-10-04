From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 2/2] OMAP3 PM: sleep code clean up
Date: Mon, 4 Oct 2010 11:56:40 +0300
Message-ID: <20101004085640.GA2529@matterhorn.lan>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
 <1285325785-6163-3-git-send-email-vishwanath.bs@ti.com>
 <8762xu9ac0.fsf@deeprootsystems.com>
 <FCCFB4CDC6E5564B9182F639FC356087034B6EC6A5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59410 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab0JDI4o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 04:56:44 -0400
Received: by bwz11 with SMTP id 11so3392316bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 01:56:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034B6EC6A5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On 10 Oct 04, Sripathy, Vishwanath wrote:
> Kevin,
 
[snip]

> >
> > But this also makes me wonder, if we're going to clean this up, the bulk
> > of it could be re-written in C, with some inline asm helpers as needed.
> Probably yes. But as this code is specific to OMAP3, do you think it's
> worth spending time on rewriting the entire code in C? It might be a
> significant effort and it will not be reusable for other ARM SOCs.

The C code will be more maintainable and offer more opportunities to
refactor across OMAP flavours - perhaps OMAP4 as well.

I'm also interested in code reuse across other SoCs. We've got to be able to
shut down the ARM core using common code instead of each SoC copying buggy
code from each other. Could you list reasons why you don't think the code is
re-usable?

Regards,
Amit
