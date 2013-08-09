From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Thu, 8 Aug 2013 22:11:47 -0700
Message-ID: <20130809051146.GB7656@atomide.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-3-git-send-email-d-gerlach@ti.com>
 <5203A0BC.8060205@ti.com>
 <5203C457.80301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49694 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab3HIFLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 01:11:51 -0400
Content-Disposition: inline
In-Reply-To: <5203C457.80301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

* Dave Gerlach <d-gerlach@ti.com> [130808 09:23]:
> On 08/08/2013 08:44 AM, Santosh Shilimkar wrote:
> >Lets address the above better. I don't see a need of 8 functions
> >exported doing one or 2 register writes.
> >
> >Look M3 based handling is going to be there on future SOCs
> >as well and this kind of handling of IPC is very short cited.
> >
> 
> The idea here was to move all control module register accesses into
> one file in planning of implementing a driver for the control module
> itself in the future.
> 
> >Probably we should have a separate driver for M3 in linux which
> >can have all this local code instead of all these exports.
> 
> The wkup_m3 code has been moved to a small driver found in patch 8
> of this series, would it better to move this code there rather than
> with the rest of the control module code?

Please make everything you can into regular device drivers.

We still have some dependencies to mach-omap2 code for PRCM
for example, but we're trying to get all that to live in
drivers.

So for new pieces, let's not add further dependencies to
complicate moving things to drivers.

Regards,

Tony
