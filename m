From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called from
 invalid context
Date: Fri, 9 Dec 2011 16:10:40 -0600
Message-ID: <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
	<1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
	<20111209213447.GB31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:45154 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181Ab1LIWKm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 17:10:42 -0500
Received: by mail-bw0-f42.google.com with SMTP id zx1so1894253bkb.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 14:10:41 -0800 (PST)
In-Reply-To: <20111209213447.GB31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 9, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
>> + =A0 =A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_=
KHZ);
=2E..
>> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_request);
>
> This does not seem right.. It seems that you're hardcoding the source
> clock to 32 KiHz clock while other sources are available too?

Agree, but... (below)

>> + =A0 =A0 ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_=
KHZ);
=2E..
> And here too?

Agree but that is the default behavior set by dm timer framework:

@@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct
omap_dm_timer *timer)
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
=2E..
-       ret =3D omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
=2E..

All clocks requested are set to 32 KHz first, even with the current
approach, there exists another API to set a new source.

To be honest I don't know why the clocks are set to 32 KHz first,
maybe the default call path for users should be:

omap_dm_timer_request
omap_dm_timer_set_source (new explicit call)
omap_dm_timer_start

And remove setting the source to 32 KHz by default in omap_dm_timer_req=
uest.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
