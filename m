From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 09/15] MAINTAINERS: Combine DSS2 and OMAPFB2 into one
	entry
Date: Mon, 11 Jan 2010 13:46:40 +0200
Message-ID: <6ed0b2681001110346w284ab362s6fd10421e81d9edd@mail.gmail.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:50255 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0AKLqm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 06:46:42 -0500
In-Reply-To: <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 8, 2010 at 3:22 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> There isn't really any reason to divide those.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> =A0MAINTAINERS | =A0 13 ++-----------
> =A01 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d2fcee..d370787 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3955,23 +3955,14 @@ L: =A0 =A0 =A0linux-omap@vger.kernel.org
> =A0S: =A0 =A0 Maintained
> =A0F: =A0 =A0 drivers/video/omap/
>
> -OMAP DISPLAY SUBSYSTEM SUPPORT (DSS2)
> +OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
> =A0M: =A0 =A0 Tomi Valkeinen <tomi.valkeinen@nokia.com>
> =A0L: =A0 =A0 linux-omap@vger.kernel.org
> =A0L: =A0 =A0 linux-fbdev@vger.kernel.org (moderated for non-subscrib=
ers)

Not that it's very important, but linux-fbdev is not really moderated
(see other entries in this file), this is probably leftover from the
old list (linux-fbdev-devel@lists.sourceforge.net).

> =A0S: =A0 =A0 Maintained
> -F: =A0 =A0 drivers/video/omap2/dss/
> -F: =A0 =A0 drivers/video/omap2/vrfb.c
> -F: =A0 =A0 drivers/video/omap2/vram.c
> +F: =A0 =A0 drivers/video/omap2/
> =A0F: =A0 =A0 Documentation/arm/OMAP/DSS
>
> -OMAP FRAMEBUFFER SUPPORT (FOR DSS2)
> -M: =A0 =A0 Tomi Valkeinen <tomi.valkeinen@nokia.com>
> -L: =A0 =A0 linux-omap@vger.kernel.org
> -L: =A0 =A0 linux-fbdev@vger.kernel.org (moderated for non-subscriber=
s)
> -S: =A0 =A0 Maintained
> -F: =A0 =A0 drivers/video/omap2/omapfb/
> -
> =A0OMAP MMC SUPPORT
> =A0M: =A0 =A0 Jarkko Lavinen <jarkko.lavinen@nokia.com>
> =A0L: =A0 =A0 linux-omap@vger.kernel.org
> --
> 1.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
