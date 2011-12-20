From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Borderline fixes for v3.2-rc6
Date: Mon, 19 Dec 2011 20:52:07 -0800
Message-ID: <CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
References: <20111219194249.GO6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57946 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab1LTEwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 23:52:08 -0500
Received: by ggdk6 with SMTP id k6so4496150ggd.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 20:52:07 -0800 (PST)
In-Reply-To: <20111219194249.GO6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

On Mon, Dec 19, 2011 at 11:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here are two fixes that could potentially go into v3.2 -rc cycle.
>
> One fixes a harmless but annoying warning that happens on omap 34xx
> processors during boot. The other one fixes booting on pretty rare
> secure mode development board, but that's fixed in "features that
> never worked earlier either" style.
>
> We can surely wait on these fixes, but if you have something going
> upstream anyways, then these might be worth considering too.

The hwmod patch is a regression so that one I'll take, the other one
is a little less obvious that it should go in now. Also, shouldn't it
be cc:d stable in that case?

Let me know what you prefer (rebase with a cc: stable) or take out the
secure mode patch. I'm collecting a small series of fixes so I'll pull
it in tomorrow for that.


-Olof
