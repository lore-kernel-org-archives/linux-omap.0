From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 0/5] uart updates
Date: Fri, 20 Jan 2012 14:15:15 +0530
Message-ID: <CAAL8m4x3uOgWFvaVP9BK1L6myDayf94fZqcQS5NvaLEvhwKnsQ@mail.gmail.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37326 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab2ATIph convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 03:45:37 -0500
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> The patch series does the following
>
> - Make the Make the suspend/resume functions depend on
> =A0 =A0CONFIG_PM_SLEEP
> - Fix the serial omap probe's error handling
> - Make he context_loss_cnt signed so that error handling is
> =A0possible.
>
>

After fixing Kevin's comment's,

If can add some testing updates it be nice.

like :
boot tested or any other tests done on xxx boards.

--
Thanks,
Govindraj.R



> Shubhrajyoti D (5):
> =A0omap-serial :Make the suspend/resume functions depend on
> =A0 =A0CONFIG_PM_SLEEP.
> =A0omap-serial: make serial_omap_restore_context depend on
> =A0 =A0CONFIG_PM_RUNTIME
> =A0omap-serial: Fix the error handling in the omap_serial probe
> =A0ARM : OMAP : serial : Make context_loss_cnt signed
> =A0OMAP : serial : Check for error in get_context_loss_count
>
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A02 +-
> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
41 ++++++++++++++++--------
> =A02 files changed, 28 insertions(+), 15 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
