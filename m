From: Kevin Hilman <khilman@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 18 May 2011 12:50:58 +0200
Message-ID: <87k4douvsd.fsf@ti.com>
References: <1305704452.1834.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55624 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932638Ab1ERKvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 06:51:12 -0400
Received: by mail-wy0-f169.google.com with SMTP id 19so1141643wyf.28
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 03:51:11 -0700 (PDT)
In-Reply-To: <1305704452.1834.12.camel@deskari> (Tomi Valkeinen's message of
	"Wed, 18 May 2011 10:40:52 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Hi Kevin,
>
> I was fixing DSS context loss handling which is a bit broken, and while
> testing on OMAP3 Overo, with -rc7 and omap2plus_defconfig, I noticed
> that get_context_loss_count() seems to always return 0.
>
> 0 should be returned when an error happens, and as far as I see in
> pwrdm_get_context_loss_count(), no error is happening but the DSS
> context has just never been lost and the returned count is thus 0.
>
> Is this correct? And what happens when the count wraps and goes back to
> zero, does the function return 0 in that case?

Hmm, you're right.  zero is actually documented as the error return
value (even though it's not really checked.)

Since driver's should only every care about the *difference* in value
between two calls to context_loss_count(), this might not be a big deal,
but a proper fix is probably to have the state counters start at one.

Kevin

