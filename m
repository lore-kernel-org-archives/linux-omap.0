From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL 2/3] omap defconfig changes for v4.2
Date: Thu, 11 Jun 2015 16:34:24 -0700
Message-ID: <7hpp51bz0f.fsf@deeprootsystems.com>
References: <556de668.8f9c6b0a.05a4.ffffe794SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34743 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbFKXe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2015 19:34:27 -0400
Received: by payr10 with SMTP id r10so10975310pay.1
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2015 16:34:27 -0700 (PDT)
In-Reply-To: <556de668.8f9c6b0a.05a4.ffffe794SMTPIN_ADDED_BROKEN@mx.google.com>
	(Tony Lindgren's message of "Tue, 2 Jun 2015 10:22:16 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/o2_dc
>
> for you to fetch changes up to 4cbb08336f506cde30c0dfb3e49c55a52842fb5c:
>
>   ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR (2015-06-02 07:54:50 -0700)
>
> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.2 merge window:
>
> - Enable dm9000 as built-in for NFSroot
>
> - Enable dm816x USB phy as a loadable module
>
> - Enable Pixcir touch screen as a loadable module
>
> ----------------------------------------------------------------

Pulled into next/defconfig.

Thanks,

Kevin
