From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in
 omap2plus_defconfig
Date: Fri, 6 Jul 2012 05:07:01 -0700
Message-ID: <20120706120700.GV1122@atomide.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4LAQXzPs_gLBn70X-VbRWTCHOk0b4afH9gn0aUur2C7FQ@mail.gmail.com>
 <CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
 <CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38666 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030326Ab2GFMHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 08:07:04 -0400
Content-Disposition: inline
In-Reply-To: <CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Partha Basak <parthab@india.ti.com>, sameo@linux.intel.com, balbi@ti.com, Kevin Hilman <khilman@ti.com>

* Munegowda, Keshava <keshava_mgowda@ti.com> [120706 05:06]:
> On Fri, Jul 6, 2012 at 5:29 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > On Fri, Jul 6, 2012 at 5:25 PM, Munegowda, Keshava
> > <keshava_mgowda@ti.com> wrote:
> >> On Fri, Jul 6, 2012 at 5:19 PM, Keshava Munegowda <keshava_mgowda@ti.com> wrote:
> >>> The usb host is disabled in the omap2 build; This is because
> >>> usb host is causing the retention to break in cpu idle.
...
> >> Sameo
> >>     please merge this patch ; this makes the core retention to work in
> >> omap2plus_defconfig
> >>
> > If at all this patch has to be merged, it should be via Tony's tree,
> > otherwise you
> > might have merge conflicts.

I think it's best to fix things properly, even if it means that it will
take longer and go into next kernel version.

Tony
