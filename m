From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 Overo: Crash on boot with Linus' master
Date: Mon, 20 Aug 2012 13:58:31 +0530
Message-ID: <CAMQu2gwFSNFy8oKpnAWiey_bUvkRXOT_x=Ej=KYA+dLN-Q6S9Q@mail.gmail.com>
References: <1343903452.2686.15.camel@deskari> <1344249504.12136.3.camel@deskari>
 <1345450118.2684.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:52420 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753906Ab2HTI2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 04:28:53 -0400
Received: by iabz21 with SMTP id z21so3163683iab.17
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 01:28:52 -0700 (PDT)
In-Reply-To: <1345450118.2684.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, tarun.kanti@ti.com, Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>

Tomi,

On Mon, Aug 20, 2012 at 1:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> Anyone ideas what could I do to debug this further? The problem exists
> on v3.6-rc2.
>
Can you try merging [1] {[GIT PULL] arm-soc: bug fixes for v3.6-rc3}
and see if it helps.

Regards
Santosh

[1] https://lkml.org/lkml/2012/8/20/120
