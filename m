From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 0/4] ARM: OMAP4: core retention support
Date: Wed, 29 Feb 2012 21:04:02 +0530
Message-ID: <CAMQu2gwHrqxZtij2mO3fgh7e8Hqr7ZTMzLxEboeT0pGK2siMOg@mail.gmail.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:42664 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031199Ab2B2Pe1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 10:34:27 -0500
Received: by mail-qw0-f48.google.com with SMTP id 2so1427428qam.7
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 07:34:22 -0800 (PST)
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, Feb 29, 2012 at 8:55 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Hi,
>
> Changes compared to previous version:
>
> - split out the io_chain set as a separate set
> - marked patch 3 as TEMP, this is only needed until Paul's pwrdm fixe=
s
> =A0get merged (http://marc.info/?l=3Dlinux-omap&m=3D133040749621183&w=
=3D2)
>
> Depends on the io_chain set to provide wakeup capability from
> retention.
>
> Tested with omap4430 blaze : suspend / resume works okay.

Thanks for fixing answering the comments on last version.
=46or entire series you can add
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
