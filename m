From: Mircea Gherzan <mgherzan@gmail.com>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Sat, 17 Mar 2012 13:57:31 +0100
Message-ID: <4F648A3B.7020003@gmail.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59706 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988Ab2CQM5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Mar 2012 08:57:37 -0400
Received: by wejx9 with SMTP id x9so4673143wej.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Mar 2012 05:57:36 -0700 (PDT)
In-Reply-To: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Mircea Gherzan <mgherzan@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

Am 06.03.2012 23:55, schrieb Mircea Gherzan:
> The "uim" deamon requires sysfs entries that are filled in using
> this platform data.
> 
> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
>  include/linux/ti_wilink_st.h           |    2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)

Gentle ping.

Thanks,
Mircea
