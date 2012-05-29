From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv5 5/8] ARM: OMAP: hwmod: Add support for per hwmod/module
 context lost count
Date: Tue, 29 May 2012 14:32:20 -0500
Message-ID: <CAOMWX4eKp+JymSNyapRJ3+u=Q1U-yMyFS5M6KUe7pOgOYyt6Ug@mail.gmail.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com> <1336989796-26594-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59819 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755757Ab2E2Tcn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 15:32:43 -0400
Received: by wgbdq11 with SMTP id dq11so3437878wgb.17
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 12:32:40 -0700 (PDT)
In-Reply-To: <1336989796-26594-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, May 14, 2012 at 5:03 AM, Tero Kristo <t-kristo@ti.com> wrote:
[...]
> +/**
> =A0* _enable - enable an omap_hwmod
> =A0* @oh: struct omap_hwmod *
> =A0*
> @@ -1599,6 +1629,8 @@ static int _enable(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0_enable_clocks(oh);
> =A0 =A0 =A0 =A0_enable_module(oh);
>
> + =A0 =A0 =A0 _omap4_update_context_lost(oh);
> +
> =A0 =A0 =A0 =A0r =3D _wait_target_ready(oh);
> =A0 =A0 =A0 =A0if (!r) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*

Dumb q: Since we monitor the count around _enable, how do we ensure
that context loss counter is accurate
around OFF and idle transitions for domains that could have been
hwauto? it might be good to have limitations
in the $commit_message if it is not targeted to do so.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
