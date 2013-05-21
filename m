From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod/serial: fix DT case
Date: Tue, 21 May 2013 11:11:10 -0700
Message-ID: <20130521181109.GR10378@atomide.com>
References: <alpine.DEB.2.00.1305192331390.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39954 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab3EUSLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 May 2013 14:11:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1305192331390.2656@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Olof,

Care to pull this into your fixes directly?

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [130519 16:39]:
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-3.10-rc
> 
> for you to fetch changes up to 3260c76055afc6c9396e5ad9f9e599505ea8891f:
> 
>   ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis (2013-05-19 16:37:15 -0600)
> 
> ----------------------------------------------------------------
> Fix the OMAP serial driver to work correctly on OMAP4 when booting
> with DT.
> 
> Basic build, boot, and PM test logs are here - unfortunately, not for
> the DT case yet:
> 
> http://www.pwsan.com/omap/testlogs/uart_idle_fix_v3.10-rc/20130519164010/
> 
> ----------------------------------------------------------------
> Rajendra Nayak (2):
>       ARM: OMAP2+: hwmod: Fix sidle programming in _enable_sysc()/_idle_sysc()
>       ARM: OMAP2+: hwmod: Add a new flag to handle SIDLE in SWSUP only in active
> 
> Santosh Shilimkar (4):
>       ARM: OMAP2+: hwmod-data: UART IP needs software control to manage sidle modes
>       ARM: OMAP2+: serial: Remove the un-used slave idle hooks
>       SERIAL: OMAP: Remove the slave idle handling from the driver
>       ARM: OMAP2+: hwmod: Remove sysc slave idle and auto idle apis
> 
>  arch/arm/mach-omap2/omap_hwmod.c                   |  111 +++++---------------
>  arch/arm/mach-omap2/omap_hwmod.h                   |    7 +-
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 +
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +-
>  arch/arm/mach-omap2/serial.c                       |   31 ------
>  drivers/tty/serial/omap-serial.c                   |   23 ----
>  include/linux/platform_data/serial-omap.h          |    2 -
>  9 files changed, 48 insertions(+), 145 deletions(-)
