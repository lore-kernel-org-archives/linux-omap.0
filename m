From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DRA752: add detection of SoC information
Date: Tue, 20 May 2014 06:20:05 -0500
Message-ID: <CAGo_u6om25s4Fxyf6LAEcoL0t0jfm_QREJuD57FQQ16E9A=bWw@mail.gmail.com>
References: <1400513231-25092-1-git-send-email-nm@ti.com>
	<537AF088.4000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:46739 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaETLUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 07:20:07 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so725929wib.12
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 04:20:06 -0700 (PDT)
In-Reply-To: <537AF088.4000506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 20, 2014 at 1:04 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> So we are back to checking revisions based on idcode register then?
> This patch was posted almost a year back and was shot down by you
> included saying we need to use dt compatibles for it.
>
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg93136.html

No, even thought it looks like, we are not intending to here. we are
fixing a sysfs break.

soc_is_dra7xx() is still based on machine_of_ compatible - we have'nt
touched that here. What is taking place at the moment is that
/sys/devices/soc0/ sysfs entries are being populated in same way as
AM437x and other DT only platforms. Currently we follow the same style
as non-dt code as OMAP3 still co-exist DT+non-DT - we have not yet
introduced a new driver for soc device - but once we go full DT, we
probably should do that at the root of the entire dt tree (similar  to
what tegra has done) and populare soc sysfs with proper values. Now,
if that generic driver decides to use only OF-information for
revision, That is good as well -> so far, there has been no attempt to
support such a revision binding (despite our discussion).


Regards,
Nishanth Menon
