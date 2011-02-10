From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/7] clock/dpll autoidle support
Date: Thu, 10 Feb 2011 14:29:22 +0530
Message-ID: <c9745c3f3f10e74f98c8f3055db96a91@mail.gmail.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:48593 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab1BJI70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 03:59:26 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so1401696fxm.40
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 00:59:24 -0800 (PST)
In-Reply-To: <1297159838-30282-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Rajendra Nayak [mailto:rnayak@ti.com]
> Sent: Tuesday, February 08, 2011 3:41 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: [PATCH 0/7] clock/dpll autoidle support
>
> OMAP has various clock nodes and dpll's
> which support hardware level autoidle.
> Enabling hardware level autoidle provides
> better power savings without much software
> intervention.
>
> This series does the following to help enable
> hardware level autoidling using clock framework
> for some of these nodes on OMAP3 and OMAP4
>
> -1- Adds support for providing function pointers
> for enabling/disabling autoidle in clkops
> -2- Populates these in clkops for all OMAP3/4 dplls
> -3- Enables all dpll autoidle late in boot on OMAP3 and OMAP4
> -4- Adds support for mx postdivider autoidle (present
> only on OMAP4) and enables it late in OMAP4 boot

Some more testing with this patch series to get OMAP4
to sleep showed a few issues, mainly with the patches
adding gate ctrl support for MX postdividers, listed below..
[PATCH 6/7] omap4: dpll: Add dpll api to control GATE_CTRL
[PATCH 7/7] omap4: dpll: Enable auto gate control for all MX postdividers

Will fix the following issues..
-1- Autogating support for clkout_x2 nodes (for PER
and ABE DPLL) was'nt addressed
-2- The clkdcoldo output (dpll_usb_clkdcoldo_ck)
of USB dpll did not have the clksel populated and
hence gate ctrl for it was'nt getting programmed.
... and post a respin of this series shortly.

Regards,
Rajendra

>
> Some of the patches in this series were earlier posted
> and discussed as part of another series here
> http://marc.info/?l=linux-omap&m=129681356402594&w=2
> They are now posted as a seperate series as discussed
> here
> http://marc.info/?l=linux-omap&m=129713867702170&w=2
>
> The patches are boot tested on OMAP3430sdp and
> OMAP4430sdp.
>
> The following changes since commit
100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:
>   Linus Torvalds (1):
>         Linux 2.6.38-rc4
>
> are available in the git repository at:
>
>  git://gitorious.org/omap-pm/linux.git dpll-autoidle
>
> Rajendra Nayak (7):
>   omap: clock: Check for enable/disable ops support
>   omap3: dpll: Populate clkops for dpll1_ck
>   omap: clock: Add allow_idle/deny_idle support in clkops
>   omap: dpll: Add allow_idle/deny_idle support for all DPLL's
>   omap: dpll: Enable all OMAP3/4 dpll autoidle late at boot
>   omap4: dpll: Add dpll api to control GATE_CTRL
>   omap4: dpll: Enable auto gate control for all MX postdividers
>
>  arch/arm/mach-omap2/clock.c             |   25 ++++++++++++++---
>  arch/arm/mach-omap2/clock.h             |    5 +++
>  arch/arm/mach-omap2/clock3xxx_data.c    |    4 +-
>  arch/arm/mach-omap2/clock44xx_data.c    |   42
+++++++++++++++---------------
>  arch/arm/mach-omap2/dpll3xxx.c          |   42
+++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm34xx.c            |   18 +++----------
>  arch/arm/mach-omap2/pm44xx.c            |    4 +++
>  arch/arm/plat-omap/clock.c              |   26 +++++++++++++++++++
>  arch/arm/plat-omap/include/plat/clock.h |    6 ++++
>  9 files changed, 130 insertions(+), 42 deletions(-)
