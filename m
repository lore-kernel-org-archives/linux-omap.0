From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC] i2c: omap: TEST: do IP reset during probe.
Date: Wed, 26 Nov 2014 13:25:52 -0800
Message-ID: <7hzjbdd57j.fsf@deeprootsystems.com>
References: <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
	<1417028722-29306-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55609 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaKZVZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 16:25:55 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so3645365pad.10
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 13:25:55 -0800 (PST)
In-Reply-To: <1417028722-29306-1-git-send-email-al.kochet@gmail.com>
	(Alexander Kochetkov's message of "Wed, 26 Nov 2014 23:05:22 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>

Alexander Kochetkov <al.kochet@gmail.com> writes:

> NOT FOR UPSTREAM
>
> The patch checks if IP reset during probe could bring I2C bus
> to a free state on omap2430 - omap3530 boards.
>
> I guess, IP hold one of I2C lines in a low state.
> I guess, u-boot haven't sent a stop condition.
>
> The patch is rebased on branch 'i2c/for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> (6e79807443cba7397cd855ed29d6faba51d4c893)
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Kevin Hilman <khilman@kernel.org>

Built for omap2plus_defconfig and tested on all my OMAP boards.  Results
here:

http://people.linaro.org/~khilman/tmp/next-20141126-1-g760388ee02e4/arm-omap2plus_defconfig/
