From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap fixes against v3.13-rc1
Date: Tue, 26 Nov 2013 19:33:06 -0800
Message-ID: <CAOesGMh8hq5UbL5ion=fgAecfkMLw3E5+2m8T2LbdqgYafFK8Q@mail.gmail.com>
References: <52954b58.8659420a.7af3.ffffeeabSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:44326 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab3K0DdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 22:33:07 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so5250447qap.18
        for <linux-omap@vger.kernel.org>; Tue, 26 Nov 2013 19:33:06 -0800 (PST)
In-Reply-To: <52954b58.8659420a.7af3.ffffeeabSMTPIN_ADDED_BROKEN@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Nov 26, 2013 at 5:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-against-rc1-take2
>
> for you to fetch changes up to 9cb238c00ba5c1ddfff2c2ed6aa66c15b962e4c3:
>
>   mmc: omap: Fix I2C dependency and make driver usable with device tree (2013-11-26 15:51:16 -0800)
>
> ----------------------------------------------------------------
> Some omap related fixes that have come up with people moving to device
> tree only based booting for omap2+.
>
> The series contains a handful of fixes for the igep boards as they were
> one of the first omap3 boards to jump over completely to device tree
> based booting. So these can be considered regressions compared to
> booting igep in legacy mode with board files in v3.12.
>
> Also included are few other device tree vs legacy booting regressions:
>
> - yet more missing omap3 .dtsi entries that have showed up booting
>   various boards with device tree only
>
> - n900 eMMC device tree fix
>
> - fixes for beagle USB EHCI
>
> - two fixes to make omap2420 MMC work
>
> As we're moving omap2+ to be device tree only for v3.14, I'd like to
> have v3.13 work equally well for legacy based booting and device tree
> based booting. So there will be likely few more device tree related
> booting patches trickling in.
>
> This series also includes a regression fix for the omap timer posted
> mode that may wrongly stay on from the bootloader for some SoCs.

Pulled, thanks. Do you have a feel for how much more of DT-vs-legacy
patches you expect for 3.13? I'm not saying no to them at this point
but it'd be good to know roughly what to expect.


-Olof
