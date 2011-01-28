From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/6] omap4: prcm: Few dpll, clockdomain and powerdomain updates
Date: Fri, 28 Jan 2011 18:07:37 +0530
Message-ID: <029aba12236fbe44e366cd12222ec138@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45171 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1A1Mhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 07:37:40 -0500
Received: by fxm5 with SMTP id 5so3245794fxm.39
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 04:37:38 -0800 (PST)
In-Reply-To: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, January 28, 2011 4:35 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@ti.com; paul@pwsan.com; b-cousson@ti.com; rnayak@ti.com;
> linux-arm-kernel@lists.infradead.org; Santosh Shilimkar
> Subject: [PATCH 0/6] omap4: prcm: Few dpll, clockdomain and
> powerdomain updates
>
> The series mainly contains dpll initialisation, CPUx clock
> domain offset fix, addiing INACTIVE power domain state and
> fixing logic flag for IVAHD and ABE power domains.
>
> The series is boot tested on OMAP4430 SDP.
>
> The following changes since commit
> 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
>   Linus Torvalds (1):
>         Linux 2.6.38-rc2
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-
> 2.6.git omap4_prcm_misc
>
With corrected git URL:
git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
omap4_prcm_misc

Regards,
Santosh
