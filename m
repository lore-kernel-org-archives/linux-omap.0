From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/2] omap: mailbox: hwmod experiment
Date: Mon, 24 May 2010 20:29:28 +0300
Message-ID: <AANLkTimiCIA7Bx3mWcFBl6UMWSYMEEufDkAUcidnQ_i_@mail.gmail.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62684 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab0EXR3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 13:29:49 -0400
Received: by gwaa20 with SMTP id a20so1597637gwa.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 10:29:48 -0700 (PDT)
In-Reply-To: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Sat, May 22, 2010 at 8:25 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I played a bit with omap_hwmod/omap_device for the mailbox, and this =
is the
> result.

Nice move Felipe :)

Can you convert this to use the runtime PM layer, instead of directly
calling omap_device functions via pdata ?

Thanks,
Ohad.

>
> I only have an OMAP3 (bb), and seems to work fine :)
>
> Felipe Contreras (2):
> =A0omap: mailbox: initial hwmod support
> =A0omap: mailbox: add omap_device latency information
>
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0107 =
+++++++---------------------
> =A0arch/arm/mach-omap2/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 34 =
+++------
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0 45 ++++++++++++
> =A0arch/arm/plat-omap/include/plat/mailbox.h =A0| =A0 =A07 ++
> =A04 files changed, 90 insertions(+), 103 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
