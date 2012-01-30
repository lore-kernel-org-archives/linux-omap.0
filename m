From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] tidspbridge: Rename module from bridgedriver to tidspbridge
Date: Mon, 30 Jan 2012 11:34:21 -0600
Message-ID: <CAB-zwWjWkxpmT2dXDV++okCKZaebVz4O8-L4OgabMEzdEu4eGA@mail.gmail.com>
References: <1327440305.1798.28.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58345 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099Ab2A3ReW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 12:34:22 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so5709670wib.27
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 09:34:21 -0800 (PST)
In-Reply-To: <1327440305.1798.28.camel@joe2Laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org, Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 24, 2012 at 3:25 PM, Joe Perches <joe@perches.com> wrote:
> tidspbridge when built as a module is named bridgedriver.
>
> bridgedriver is not a particularly good module name.
>
> tidspbridge is what the source is named. =A0That seems
> a more appropriate module name too as it describes
> the hardware function better.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =A0drivers/staging/tidspbridge/Makefile | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/Makefile b/drivers/staging/t=
idspbridge/Makefile
> index fd6a276..8c8c92a 100644
> --- a/drivers/staging/tidspbridge/Makefile
> +++ b/drivers/staging/tidspbridge/Makefile
> @@ -1,4 +1,4 @@
> -obj-$(CONFIG_TIDSPBRIDGE) =A0 =A0 =A0+=3D bridgedriver.o
> +obj-$(CONFIG_TIDSPBRIDGE) =A0 =A0 =A0+=3D tidspbridge.o
>
> =A0libgen =3D gen/gh.o gen/uuidutil.o
> =A0libcore =3D core/chnl_sm.o core/msg_sm.o core/io_sm.o core/tiomap3=
430.o \
> @@ -13,7 +13,7 @@ libdload =3D dynload/cload.o dynload/getsection.o d=
ynload/reloc.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dynload/tramp.o
> =A0libhw =3D hw/hw_mmu.o
>
> -bridgedriver-y :=3D $(libgen) $(libservices) $(libcore) $(libpmgr) $=
(librmgr) \
> +tidspbridge-y :=3D $(libgen) $(libservices) $(libcore) $(libpmgr) $(=
librmgr) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(libdload) $(libhw)
>
> =A0#Machine dependent
>
>

Sound good to me, and unless there is an objection, it also gives
plenty of time for the change to be noticed.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
