From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap multiplatform warning fixes for v3.9 merge window
Date: Sat, 9 Feb 2013 20:27:25 -0800
Message-ID: <CAOesGMjC2NVOuY1D3HK33esJpWa65Nbgj90LoD=6ALcsePeWmA@mail.gmail.com>
References: <20130210041949.GG4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34578 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761060Ab3BJE11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 23:27:27 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so2135271wib.6
        for <linux-omap@vger.kernel.org>; Sat, 09 Feb 2013 20:27:26 -0800 (PST)
In-Reply-To: <20130210041949.GG4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,


On Sat, Feb 9, 2013 at 8:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit ad1bb1b4e01c5ecbe32133ce6921d0e76cb76dcf:
>
>   ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S (2013-01-11 11:24:20 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/multiplatform-fixes-signed-v2

Sorry for the confusion on this; I obviously already had the
hwspinlock patch but I hadn't pushed it out.

So, to make things a little easier I just cherry-picked over the two I
didn't have. Thanks for staging them though. :)


They're all in next/multiplatform now. I'll push out shortly as soon
as my test build completes.


-Olof
