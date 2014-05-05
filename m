From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] somewhat urgent omap fixes against v3.15-rc1, fixes
 gpmc
Date: Sun, 4 May 2014 22:21:08 -0700
Message-ID: <20140505052108.GC16022@quad.lixom.net>
References: <20140425203047.GG20807@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39835 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbaEEFVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 01:21:04 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so3935311pdi.23
        for <linux-omap@vger.kernel.org>; Sun, 04 May 2014 22:21:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140425203047.GG20807@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Apr 25, 2014 at 01:30:48PM -0700, Tony Lindgren wrote:
> The following changes since commit fb677ef70b65e22cd4401d31b700a8b4041efae1:
> 
>   ARM: OMAP2+: Fix GPMC remap for devices using an offset (2014-04-23 11:09:22 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-gpmc
> 
> for you to fetch changes up to 4c05160342f16361fc37ae34dcae9210306a83e9:
> 
>   ARM: dts: AM3517: Disable absent IPs inherited from OMAP3 (2014-04-25 09:55:00 -0700)
> 
> ----------------------------------------------------------------
> Mostly fixes for occasional memory corruption caused by bad
> timings for smc911x LAN9220 (and potentially LAN9221) devices
> that were noted on a cm-t3730 system. Also fix THUMB mode
> for SMP, and mailbox related warnings when booted with device
> tree.

Merged into fixes.


-Olof
