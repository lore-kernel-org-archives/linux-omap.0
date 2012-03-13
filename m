From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: declare file-local functions as static
Date: Tue, 13 Mar 2012 12:42:59 +0530
Message-ID: <CAMQu2gwJGGL8VKuNxUmH5BbCYhTQCBDW7TbsE4RjCziE9TWCVQ@mail.gmail.com>
References: <20120312224006.4103.29464.stgit@dusk> <20120312224251.4103.76124.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42453 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753177Ab2CMHNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 03:13:20 -0400
Received: by mail-yw0-f41.google.com with SMTP id 47so253297yhr.14
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 00:13:19 -0700 (PDT)
In-Reply-To: <20120312224251.4103.76124.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj R <govindraj.raja@ti.com>, Simon Que <sque@ti.com>, David Anders <x0132446@ti.com>

On Tue, Mar 13, 2012 at 4:12 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Several function declarations used only in the files in which they're
> declared should include the static keyboard, but don't:
>
> =A0 =A0arch/arm/mach-omap2/serial.c:248:6: warning: symbol 'cmdline_f=
ind_option' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/omap-wakeupgen.c:259:6: warning: symbol 'i=
rq_sar_clear' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-rx51-peripherals.c:878:27: warning: =
symbol 'rx51_vibra_data' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-rx51-peripherals.c:882:27: warning: =
symbol 'rx51_audio_data' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-omap4panda.c:201:29: warning: symbol=
 'omap_panda_wlan_data' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-omap4panda.c:393:24: warning: symbol=
 'omap4_panda_dvi_device' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-omap4panda.c:403:12: warning: symbol=
 'omap4_panda_dvi_init' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-omap4panda.c:464:6: warning: symbol =
'omap4_panda_display_init' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/hsmmc.c:434:6: warning: symbol 'omap_init_=
hsmmc' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/hwspinlock.c:31:12: warning: symbol 'hwspi=
nlocks_init' was not declared. Should it be static?
>
> Mark all of these as static.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: David Anders <x0132446@ti.com>
> Cc: Simon Que <sque@ti.com>
> ---
=46or the wakeupgen change,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
