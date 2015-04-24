From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Fri, 24 Apr 2015 10:54:29 +0200
Message-ID: <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
References: <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk> <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk> <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth> <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth> <20150420234032.GM18048@atomide.com> <20150423102542.GZ4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34434 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934279AbbDXIyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2015 04:54:50 -0400
Received: by wgso17 with SMTP id o17so43535596wgs.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2015 01:54:49 -0700 (PDT)
In-Reply-To: <20150423102542.GZ4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 23 April 2015 at 12:25, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> And you can't detect whether you're running in secure mode or not.

If not, you get an undefined instruction exception, which you could trap.

This may not be convenient, but "can't detect" is an overstatement.

Matthijs
