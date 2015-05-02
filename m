From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Sat, 2 May 2015 08:51:38 +0200
Message-ID: <CAALWOA-3_4jpdwY-D07i1_Q0Q2sLsYXSEoJXX7+stnXBZR7yqg@mail.gmail.com>
References: <20150407135713.GL4027@n2100.arm.linux.org.uk> <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk> <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth> <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth> <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk> <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
 <20150428181109.GA4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33457 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbEBGwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 May 2015 02:52:00 -0400
Received: by wgin8 with SMTP id n8so106996744wgi.0
        for <linux-omap@vger.kernel.org>; Fri, 01 May 2015 23:51:59 -0700 (PDT)
In-Reply-To: <20150428181109.GA4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 28 April 2015 at 20:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> "Can't detect" is _not_ an overstatement.  It's a statement that I'm
> giving you through my experience and knowledge of the Linux kernel,
> the ARM archtecture, the capabilities of the platforms we have to
> deal with, and how we want the kernel to work.
>
> Sure, we _can_ detect it if (and only if) we code specifically for a
> platform which has RAM at the CPU vector location.  Unfortunately,
> that's a _very_ small proportion which approximates a number very
> close to zero.

Sorry, I clearly had never adequately appreciated how much of a luxury
it is to be targeting only a limited range of platforms, or the burden
of the constraints imposed by needing to support the bewildering
diversity out there.

However, your objection isn't quite valid either since any ARM cpu
supporting the security extensions also supports changing the vector
base address.

Matthijs
