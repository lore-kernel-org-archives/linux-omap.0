From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
Date: Wed, 10 Nov 2010 17:52:20 +0100
Message-ID: <4CDACDC4.8010504@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55193 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075Ab0KJQwA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 11:52:00 -0500
In-Reply-To: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hari,

I forgot one comment. Since this series is a v2, every patches subject 
should contain the [PATCH v2 x/6].

FYI, patchwork will not track the cover letter, so we will miss that 
version information in the real patches.

I forgot as well this subject:
     mailbox: change full flag per mailbox queue instead of global

Should be
     OMAP: mailbox: change full flag per mailbox queue instead of global

Since it is purely omap stuff.

Regards,
Benoit

On 11/10/2010 1:45 PM, Hari Kanigeri wrote:
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
>    mailbox: change full flag per mailbox queue instead of global
>
> Hari Kanigeri (5):
>    omap:mailbox: fix rx interrupt disable in omap4
>    omap:mailbox-fix checkpatch warnings
>    omap:mailbox-send message in process context
>    omap:mailbox-add notification support for multiple readers
>    omap:clocks44x-add dummy clock for mailbox
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

