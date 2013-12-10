From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL] wl1251 platform data changes for v3.14
Date: Tue, 10 Dec 2013 08:02:40 -0800
Message-ID: <87bo0oae3j.fsf@linaro.org>
References: <52a69d42.0722440a.102e.ffffa0e3SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53059 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab3LJQCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 11:02:43 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so7927940pbb.32
        for <linux-omap@vger.kernel.org>; Tue, 10 Dec 2013 08:02:42 -0800 (PST)
In-Reply-To: <52a69d42.0722440a.102e.ffffa0e3SMTPIN_ADDED_BROKEN@mx.google.com>
	(Tony Lindgren's message of "Mon, 9 Dec 2013 20:49:00 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 736e812636ea72be444b85fa7e92554967459069:
>
>   ARM: OMAP2+: Remove unused platform init code and headers (2013-12-08 14:15:46 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/omap3-board-removal-wl1251
>
> for you to fetch changes up to ce226391aec803a49b39c22d3385057c9db02f30:
>
>   Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal (2013-12-09 19:39:51 -0800)
>
> ----------------------------------------------------------------
>
> Minimal changes for the wl151 platform data that would otherwise
> cause merge conflicts between the wireless tree and linux-omap
> tree. This was discussed on the mailing lists here:
>
> http://www.spinics.net/lists/linux-omap/msg99906.html
>
> ----------------------------------------------------------------
> Luciano Coelho (1):
>       wl1251: split wl251 platform data to a separate structure
>
> Sebastian Reichel (1):
>       wl1251: move power GPIO handling into the driver
>
> Tony Lindgren (1):
>       Merge branch 'wl1251-pdata' into omap-for-v3.14/omap3-board-removal
>
>  drivers/net/wireless/ti/wilink_platform_data.c | 37 +++++++++++++++++++++-----
>  drivers/net/wireless/ti/wl1251/sdio.c          | 31 ++++++++++++++-------
>  drivers/net/wireless/ti/wl1251/spi.c           | 35 +++++++++++++++---------
>  drivers/net/wireless/ti/wl1251/wl1251.h        |  2 +-
>  include/linux/wl12xx.h                         | 24 +++++++++++++++--
>  5 files changed, 97 insertions(+), 32 deletions(-)

This was sent as a pull request to arm-soc, but looks like it should be
going through the net tree.

Kevin
