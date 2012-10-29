From: Afzal Mohammed <x0148406@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Mon, 29 Oct 2012 13:40:55 +0530
Message-ID: <508E3A0F.3040309@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab2J2ILC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 04:11:02 -0400
In-Reply-To: <50887A6B.3050108@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, paul@pwsan.com, nsekhar@ti.com

Hi Daniel,

On Thursday 25 October 2012 05:01 AM, Daniel Mack wrote:

> Thanks for the review. I'll wait for feedback from Afzal next week and
> then repost. Wanted to see first if that goes in the right direction at
> all before bordering the DT people with binding details :)

I was thinking of a generic approach, where there won't be
any check for peripheral device type.

But going that path would delay achieving DT, may be let's
proceed with your approach to start with so that we can
have a minimal level of DT support for GPMC and probably
we can make it generic later. While adding new properties,
it would be better to keep in mind that we need not change
these later once gpmc DT is made generic.

Regarding the bindings, there are some generic nand
properties like ecc already available, may be that be made
use here. Also perhaps memory size (and offset if
needed) to be mapped for peripherals can go with reg
property of child.

Regards
Afzal
