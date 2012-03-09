From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Fri, 9 Mar 2012 13:08:17 +0200
Message-ID: <CANOLnOOdnJ4OGrhBdF5h_NyYHZ4FPsJet+0M=fGCygQDOsWByQ@mail.gmail.com>
References: <87r4x27gh0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49573 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab2CILIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 06:08:18 -0500
Received: by yhmm54 with SMTP id m54so751542yhm.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 03:08:17 -0800 (PST)
In-Reply-To: <87r4x27gh0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Fri, Mar 9, 2012 at 2:42 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Tomi,
>
> A while ago you were asking about why DSS pwrdm counts were so high o=
n
> OMAP3, and why DSS was transitioning even though it was completely
> unused. Paul and I just spent some a little time debugging this, and
> narrowed it down to autodeps. (sorry it took so long, it finally
> bothered me enough to actually look into it.)

I've seen the same happening to usbhost_pwrdm in linux-next, maybe it
needs similar patch?

Talking about linux-next, musb is crashing there on first register
access, just after pm_runtime_get_sync(), maybe something's up with
clock related code? CONFIG_PM_RUNTIME was enabled there.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
