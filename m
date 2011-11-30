From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Tue, 29 Nov 2011 16:39:26 -0800
Message-ID: <87obvuzbnl.fsf@ti.com>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:50373 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757054Ab1K3Aja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 19:39:30 -0500
Received: by mail-iy0-f180.google.com with SMTP id z35so15285267iag.11
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 16:39:29 -0800 (PST)
In-Reply-To: <1322528190-9274-1-git-send-email-khilman@ti.com> (Kevin Hilman's
	message of "Mon, 28 Nov 2011 16:56:30 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, p-basak2@ti.com

Kevin Hilman <khilman@ti.com> writes:

> The MUSB driver does not currently implment suspend/resume callbacks,
> seemingly because it does not support cutting power when devices are
> connected in host mode.
>
> Without a proper suspend/resume implementation, the OMAP PM domain
> layer which automatically gates non runtime-suspended devices will
> cause problems in suspend by the drivers ->runtime_suspend() callback
> which will try to cut power.
>
> Fix this by disabling PM domain auto suspending for MUSB until the
> driver can be fixed to properly implement suspend/resume.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

I guess it's obvious, but should be stated (I'll update the changelog):

Also note that this prevents the CORE powerdomain from hitting retention
(or off), and thus prevents full-chip retention/off whenever USB devices
are attatched, so this should not be considered as a real fix, but a
workaround that at least prevents driver failure.

Kevin
