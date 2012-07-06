From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in
 omap2plus_defconfig
Date: Fri, 6 Jul 2012 05:39:13 -0700
Message-ID: <20120706123913.GX1122@atomide.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4LAQXzPs_gLBn70X-VbRWTCHOk0b4afH9gn0aUur2C7FQ@mail.gmail.com>
 <CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
 <CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
 <20120706120700.GV1122@atomide.com>
 <CAP05o4L6CXjgDCe_eoY15aKFNDf7vMcYJGOqxpE3rMPSAxU57w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41098 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2GFMjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:39:15 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4L6CXjgDCe_eoY15aKFNDf7vMcYJGOqxpE3rMPSAxU57w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Partha Basak <parthab@india.ti.com>, sameo@linux.intel.com, balbi@ti.com, Kevin Hilman <khilman@ti.com>

* Munegowda, Keshava <keshava_mgowda@ti.com> [120706 05:30]:
> On Fri, Jul 6, 2012 at 5:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > I think it's best to fix things properly, even if it means that it will
> > take longer and go into next kernel version.
> 
>     This requires ehci remote wakeup feature to be implemented, which
> will take at least to 3 months to
> get reviewed in opensource.
> hence for now  kevin is also agreed to disable it by default;

Why does echi need a "remote wakeup" feature? If you're talking about
echi wake-up events, I don't see how that would affect core retention.

Tony
