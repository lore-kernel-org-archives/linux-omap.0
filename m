From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC PATCH 0/2] staging: tidspbridge: detecting wdt from baseimage
Date: Wed, 15 Feb 2012 13:42:25 +0200
Message-ID: <CAMP44s1pPZ4oTVRKDf7mxijRNHnY1p_QynzCgRjjx-nEeT49Ow@mail.gmail.com>
References: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59585 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752034Ab2BOLm0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 06:42:26 -0500
Received: by lagu2 with SMTP id u2so873975lag.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 03:42:25 -0800 (PST)
In-Reply-To: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, devel@driverdev.osuosl.org, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>

On Wed, Feb 15, 2012 at 5:00 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> This is an alternate solution for:
>
> WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq...
> In-band Error seen by IVA_SS =C2=A0at address 0
>
> Instead of setting CONFIG_TIDSPBRIDGE_WDT3 to 'default y', these patc=
hes
> include the code to be compiled for runtime detection of this feature
> based on baseimage symbols.
>
> As mentioned in the description of the first patch, we will lose the =
option
> to set a current overflow timeout and the default will be kept as 5 s=
econds.
> This can be replaced by a debugfs/sysfs entry if needed, I didn't inc=
lude
> such a patch as we first need to decide which fix to take (between th=
is and
> default y for CONFIG_TIDSPBRIDGE_WDT3[1]).
>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg62119.h=
tml

LGTM.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
