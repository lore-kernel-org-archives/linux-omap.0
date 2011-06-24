From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Fri, 24 Jun 2011 15:27:03 -0700
Message-ID: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61908 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab1FXW1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 18:27:05 -0400
Received: by qwk3 with SMTP id 3so1530245qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 15:27:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
=2E..
>
> As I understand it, in the original Android implementation, the hardw=
are
> that they were using didn't have fine-grained power management. =A0So
> system-wide suspend made more sense in that context. =A0But that shou=
ldn't
> be confused with the modern rationale for wakelocks:
>
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668=
=2Ehtml
>
> "On the hardware that shipped we enter the same power state from idle
> and suspend, so the only power savings we get from suspend that we
> don't get in idle is from not respecting the scheduler and timers."
>

This is no longer the case. Both the Nexus-S and Xoom enter lower
power states from suspend than idle.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
