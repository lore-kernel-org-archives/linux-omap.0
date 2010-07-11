From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH]omap:dmtimer:no null check for kzalloc
Date: Sun, 11 Jul 2010 21:02:45 +0300
Message-ID: <1278871365.3212.18.camel@localhost.localdomain>
References: <1278886185-12502-1-git-send-email-tarun.kanti@ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41069 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0GKSCv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jul 2010 14:02:51 -0400
Received: by bwz1 with SMTP id 1so1972630bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Jul 2010 11:02:50 -0700 (PDT)
In-Reply-To: <1278886185-12502-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: olbpdev@list.ti.com, linux-omap@vger.kernel.org

On Mon, 2010-07-12 at 03:39 +0530, Tarun Kanti DebBarma wrote:
> +                       if (!pdata) {
> +                               pr_err("%s: \
> +                               No memory for omap_dm_timer_plat_info=
\n",
> +                               __func__);
> +                               return -ENOMEM;
> +                       }

do not use concatenation ('\'), this is probably not what you want.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
