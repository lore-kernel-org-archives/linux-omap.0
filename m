From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v3.18-rc4
Date: Sun, 16 Nov 2014 15:10:48 -0800
Message-ID: <20141116231048.GC14929@quad.lixom.net>
References: <20141111165357.GB26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35206 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaKPXKv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Nov 2014 18:10:51 -0500
Received: by mail-pa0-f54.google.com with SMTP id hz1so9744673pad.41
        for <linux-omap@vger.kernel.org>; Sun, 16 Nov 2014 15:10:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141111165357.GB26481@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Nov 11, 2014 at 08:53:58AM -0800, Tony Lindgren wrote:
> The following changes since commit 4b91f7f3c8b20e073b7bfc098625b37f99789508:
> 
>   ARM: OMAP2+: Warn about deprecated legacy booting mode (2014-10-29 12:19:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-against-v3.18-rc4
> 
> for you to fetch changes up to 73b3a6657a88ef5348a0d69c9a8107d6f01ae862:
> 
>   pinctrl: dra: dt-bindings: Fix output pull up/down (2014-11-10 14:29:20 -0800)
> 
> ----------------------------------------------------------------
> Few omap fixes for hangs and wrong pinctrl defines, and update
> MAINTAINERS file to avoid missing PMIC and SoC related patches:
> 
> - Fix random hangs on am437x because of incorrect default
>   value for the DDR regulator
> 
> - Fix wrong partition name for NAND on am335x-evm
> 
> - Fix wrong pinctrl defines for dra7xx
> 
> - Update maintainers entries for PMICs and SoCs

Merged. Might miss today's -rc though.


-Olof
