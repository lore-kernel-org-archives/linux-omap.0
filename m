From: Kevin Hilman <khilman@ti.com>
Subject: Re: Bringing back gptimer_wakeup
Date: Mon, 18 Jun 2012 11:01:59 -0700
Message-ID: <87k3z4lcrs.fsf@ti.com>
References: <4FDEF24C.8020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55042 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751464Ab2FRSCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 14:02:07 -0400
Received: by pbcwy7 with SMTP id wy7so8593613pbc.31
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 11:02:01 -0700 (PDT)
In-Reply-To: <4FDEF24C.8020305@gmail.com> (Tasslehoff Kjappfot's message of
	"Mon, 18 Jun 2012 11:18:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

Tasslehoff Kjappfot <tasskjapp@gmail.com> writes:

> The support for using a timer to wake from suspend was removed in:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864
>
> I found an alternative patch
> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html)
> that claimed to keep it working using GPTIMER1 instead, but I haven't
> been able to make it work (likely because the timer code has changed a
> good deal since the patch was posted).
>
> Anyone got
> a) a patch that enables this feature on newer kernels, or
> b) an idea how the patch above can be made to work?

The branch below (based on v3.4) will work (at least on OMAP3)

We've been holding off on putting this back becasue the timer interface
has been going through some major cleanup/rework, but I would like to
see this make it back in soonish.

Kevin

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-wip/wakeup-timer
