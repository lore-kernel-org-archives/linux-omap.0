From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/6] [v2] OMAP: mailbox: enhancements and fixes
Date: Wed, 10 Nov 2010 20:15:50 +0100
Message-ID: <4CDAEF66.50003@ti.com>
References: <1289412018-18860-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36684 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936Ab0KJTOd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 14:14:33 -0500
In-Reply-To: <1289412018-18860-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 11/10/2010 7:00 PM, Hari Kanigeri wrote:
> Resending correcting the subject format based on Benoit's comment and
> fixing the over-indentation pointed out by Sergei.

Pure nitpicking:
That's a pretty fast update... but then it should be a v3 :-)

Why does the cover letter not use the same format?
[PATCH 0/6] [v2] instead of  [PATCH v2 0/6]

Thanks,
Benoit

>
> Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
> set.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37278.html
>
> The patch set addresses the following review comments from Rene and Omar.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37626.html
> https://patchwork.kernel.org/patch/255091/
> https://patchwork.kernel.org/patch/255081/
>
> Following patches are changed because of above review comments:
> omap:mailbox-send message in process context
> omap:mailbox-add notification support for multiple readers
>
> Following patch is dropped from initial patch set
> omap:mailbox-resolve multiple receiver problem
>
> The patch set is tested on omap4 SDP board.
>
> Fernando Guzman Lugo (1):
>    OMAP: mailbox: change full flag per mailbox queue instead of global
>
> Hari Kanigeri (5):
>    OMAP: mailbox: fix rx interrupt disable in omap4
>    OMAP: mailbox: fix checkpatch warnings
>    OMAP: mailbox: send message in process context
>    OMAP: mailbox: add notification support for multiple readers
>    OMAP4: clocks: add dummy clock for mailbox
>
>   arch/arm/mach-omap2/clock44xx_data.c      |    1 +
>   arch/arm/mach-omap2/mailbox.c             |    5 +-
>   arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
>   arch/arm/plat-omap/mailbox.c              |  127 +++++++++++++++++------------
>   4 files changed, 83 insertions(+), 58 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

