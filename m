From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 0/6] ARM: OMAP3+: minor PM core code cleanup
Date: Mon, 30 Jul 2012 13:53:59 -0700
Message-ID: <871ujtgec8.fsf@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36953 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754470Ab2G3UyC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 16:54:02 -0400
Received: by pbbrr13 with SMTP id rr13so11912394pbb.40
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 13:54:01 -0700 (PDT)
In-Reply-To: <1342197459-7920-1-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 13 Jul 2012 19:37:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero, Paul,

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> Following set moves some PRM related code away from PM core code to
> PRM / HWMOD. This requires the hwmod cleanup set from Paul that
> implements the setup_preprogram hooks for hwmods. Sending as RFC for
> initial commenting.

What is the status of the setup_preprogram hooks patch(es)?  Looks like
that part was dropped from Paul's original series of fixes.

Just curious,

Kevin

> This set does following:
> - gets rid of the prcm interrupt handler from pm34xx.c
> - removes iva_idle from pm34xx.c
> - removes d2d_idle from pm34xx.c
>
> There are some side-effects though, it looks like the reset statuses
> for iva / d2d modules are rather flaky, and some failed hardreset
> warnings are generated during boot. PM works fine though and the
> modules are put to idle properly. Could use some ideas how to handle
> this, maybe add a flag for ignoring the hardreset status completely...?
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
