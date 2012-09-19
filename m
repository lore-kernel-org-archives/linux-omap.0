From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: Enable arch timer support
Date: Wed, 19 Sep 2012 13:23:33 +0530
Message-ID: <CAMQu2gxhOsMoaZfNkkx+j=bGCWOvGTWme-ZmEhJoAcUYDxtXcQ@mail.gmail.com>
References: <1348041069-947-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:54268 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab2ISHxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 03:53:54 -0400
Received: by vcbfo13 with SMTP id fo13so849260vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 00:53:53 -0700 (PDT)
In-Reply-To: <1348041069-947-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

(With fixed git URL)

On Wed, Sep 19, 2012 at 1:21 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
> Tony,
>
> Here is the pull request which enables the architected cpu local timer
> support for OMAP5 devices.
>
> The following changes since commit
> 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
>
>   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
>
> are available in the git repository at:
>
>   git@github.com:SantoshShilimkar/linux.git for_3.7/omap5_arch_timer

git://github.com/SantoshShilimkar/linux.git for_3.7/omap5_arch_timer

>
> for you to fetch changes up to 3c7c5dab44d6c8861bc86dab924353d8d40344f8:
>
>   ARM: OMAP5: Enable arch timer support (2012-09-19 13:00:37 +0530)
>
> ----------------------------------------------------------------
> Santosh Shilimkar (2):
>       ARM: OMAP: Add initialisation for the real-time counter.
>       ARM: OMAP5: Enable arch timer support
>
>  arch/arm/boot/dts/omap5.dtsi |   12 ++++++
>  arch/arm/mach-omap2/Kconfig  |    5 +++
>  arch/arm/mach-omap2/timer.c  |   97
> +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 113 insertions(+), 1 deletion(-)
