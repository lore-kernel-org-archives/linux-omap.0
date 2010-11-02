From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add dummy panel display driver
Date: Tue, 2 Nov 2010 19:21:57 +0200
Message-ID: <AANLkTikd-hMcFkanO4SUceJuvrMoLxxcB4Fw3HvU_8-w@mail.gmail.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57103 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0KBRV6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 13:21:58 -0400
Received: by pwj3 with SMTP id 3so1670126pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 10:21:58 -0700 (PDT)
In-Reply-To: <1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 2, 2010 at 6:13 PM, Bryan Wu <bryan.wu@canonical.com> wrote=
:
> Dummy panel driver includes the driver and 4 similar panel configurat=
ions. It
> will match the panel name which is passed from platform data and setu=
p the
> right configurations.
>
> With dummy panel driver, we can remove those 4 duplicated panel displ=
ay
> drivers. In the future, it is simple for us just add new panel config=
uration
> date in panel-dummy.h to support new display panel.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

<snip>

> diff --git a/drivers/video/omap2/displays/panel-dummy.h b/drivers/vid=
eo/omap2/displays/panel-dummy.h
> new file mode 100644
> index 0000000..ac2b7a2
> --- /dev/null
> +++ b/drivers/video/omap2/displays/panel-dummy.h

There is no benefit of having this header, just add all data directly
in .c file.

<snip>

> + =A0 =A0 =A0 /* Sharp LQ043T1DG01 */
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =
=A0=3D 272,

missing newline after {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
