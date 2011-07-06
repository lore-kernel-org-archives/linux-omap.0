From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force
 sleep
Date: Tue, 5 Jul 2011 23:30:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107052329400.4217@utopia.booyaka.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com> <1307616853-28395-2-git-send-email-rnayak@ti.com> <1307616853-28395-3-git-send-email-rnayak@ti.com> <1307616853-28395-4-git-send-email-rnayak@ti.com> <1307616853-28395-5-git-send-email-rnayak@ti.com>
 <1307616853-28395-6-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1106230819540.12954@utopia.booyaka.com> <20110623152249.GG9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36176 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab1GFFaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 01:30:02 -0400
In-Reply-To: <20110623152249.GG9449@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rajendra Nayak <rnayak@ti.com>, khilman@ti.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 23 Jun 2011, Russell King - ARM Linux wrote:

> Do you really want to continue pissing Linus off with churn like this
> rather than pressing to get problems fixed _properly_ (eg, getting the
> HSMMC driver fixed) ?

Thanks for your comments.  We won't queue this patch.


- Paul
