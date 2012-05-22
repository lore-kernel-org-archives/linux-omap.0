From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/7] remoteproc: resource table overhaul
Date: Tue, 22 May 2012 12:22:05 +0300
Message-ID: <CAK=WgbYKMh8oifeC-A9LYq8GV_Nb7L8wc198YZujGEsp9mmvsw@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com> <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
 <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com> <4FBB5908.4010505@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38929 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab2EVJWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 05:22:25 -0400
Received: by ghrr11 with SMTP id r11so683458ghr.19
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 02:22:25 -0700 (PDT)
In-Reply-To: <4FBB5908.4010505@stericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: frq09524 <ludovic.barre@stericsson.com>
Cc: Michal Simek <monstr@monstr.eu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Swetland <swetland@google.com>, Iliyan Malchev <malchev@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Rusty Russell <rusty@rustcorp.com.au>, Mark Grosen <mgrosen@ti.com>, John Williams <john.williams@petalogix.com>, Loic PALLARDY <loic.pallardy@stericsson.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Anna Suman <s-anna@ti.com>, Clark Rob <rob@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Saravana Kannan <skannan@codeaurora.org>, David Brown <davidb@codeaurora.org>, Kieran Bingham <kieranbingham@gmail.com>, Tony Lindgren <tony@atomide.com>

Hi Ludovic,

On Tue, May 22, 2012 at 12:14 PM, frq09524 <ludovic.barre@stericsson.com> wrote:
> Ohad, for alignment I can take the latest branch of kernel.org (remoteproc)
> branch for-next?

Sure, it's pretty much updated sans a few simple changes.

Thanks,
Ohad.
