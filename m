From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Fri, 4 Mar 2011 17:35:01 +0000
Message-ID: <AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56117 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1CDRfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:35:03 -0500
Received: by yia27 with SMTP id 27so848112yia.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 09:35:01 -0800 (PST)
In-Reply-To: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

On Fri, Mar 4, 2011 at 3:33 PM, Dave Martin <dave.martin@linaro.org> wr=
ote:
> This set of patches, along with some other patches under
> discussion on alkml, should enable omap3 and omap4 kernels to be
> built with CONFIG_THUMB2_KERNEL.
>
> This patch set builds on recent cleanup done by the omap
> maintainers.
>
> At least some of this code definitely works, most features have
> been tested successfully. =A0Further testing, especially of Thumb-2
> behaviour, is still welcome.
>
> In particular, I still have no Ack/Tested-by on the following
> patches, so it would be great if anyone who has an opportunity
> to do a final review / re-test can do so.
>
> =A0* ARM: omap3: Convert END() to ENDPROC() for correct linkage with =
CONFIG_THUMB2_KERNEL
> =A0* ARM: omap3: Thumb-2 compatibility for sram34xx.S
> =A0* ARM: omap3: Thumb-2 compatibility for sleep34xx.S

=46ollowing up on this, it looks like I have some locally-recorded acks
which didn't make it into my posting ...

The one patch I currently have no feedback on is this one:

  * ARM: omap4: Provide do_wfi() for Thumb-2

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
