From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 0/2] Add D2D clockdomain on OMAP3 ES2+
Date: Fri, 23 May 2008 09:27:09 +0300
Message-ID: <87wsllmt6q.fsf@trdhcp146196.ntc.nokia.com>
References: <20080522173035.1292.74243.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62137 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYEWG1m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2008 02:27:42 -0400
In-Reply-To: <20080522173035.1292.74243.stgit@localhost.localdomain> (ext Paul
	Walmsley's message of "Thu, 22 May 2008 11:33:47 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello,
>
> This patch series adds D2D (die-to-die) clockdomain handling into
> OMAP3 ES2+ builds.  It seems the D2D clockdomain logic is still
> present on the chip and must be manually programmed to allow the
> CORE_D2D clockdomain to go inactive.
>
> For this to work, the pm34xx.c code also had to be modified to use th=
e
> pwrdm_for_each_clkdm() iterator, lest the existing for-loop fall off
> the end of pwrdm->pwrdm_clkdms[].  This also should fix an oops with
> CONFIG_PM on any 3430ES1 boards out there.

That loop was a good catch, thanks.

Both patches acked.

>
> Tested on 3430SDP ES2.0.
>
>
> - Paul
>
>
> diffstat:
>  arch/arm/mach-omap2/clockdomains.h |    9 ++++++++-
>  arch/arm/mach-omap2/pm34xx.c       |   23 ++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> size:
>    text    data     bss     dec     hex filename
> 3280225  155416   98792 3534433  35ee61 vmlinux.3430sdp.orig
> 3280305  155416   98792 3534513  35eeb1 vmlinux.3430sdp.patched
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
