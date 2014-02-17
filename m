From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] arm: omap3: cm-t35: remove MACH_CM_T3730
Date: Mon, 17 Feb 2014 13:48:13 +0100
Message-ID: <1392641293.13000.9.camel@x220>
References: <1392571560.28866.16.camel@x220> <5302017F.40900@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:55552 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552AbaBQMsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Feb 2014 07:48:15 -0500
In-Reply-To: <5302017F.40900@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Igor,

On Mon, 2014-02-17 at 14:33 +0200, Igor Grinberg wrote:
> On 02/16/14 19:26, Paul Bolle wrote:
> > The Kconfig symbol MACH_CM_T3730 was added in v3.1. It has never been
> > used. Setting it has no effect. There are no calls for
> > machine_is_cm_t3730(). This symbol can safely be removed.
> 
> Indeed...

Please note that I now doubt my reasoning was correct here. I'm going to
revisit my recent batch of patches regarding, in short, arm Kconfig
symbols used in mach-types.h. (lkml.org is sort of down, so I can't
provide a link.)

> Is it such a burden to keep it just until we switch OMAP3 to DT?
> Because, it makes a bit harder to hack on the kernel.
> Well, not too much as it can be reverted, but still one needs
> to remember to do this...

No, not really. The worst that could happen, from your perspective, is
that if it turns out this was the right thing to do, I might send a
reminder in a few months.

> I'd like to keep it just until we remove the board files, please.

Thanks,


Paul Bolle

