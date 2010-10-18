From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 17:35:49 +0200
Message-ID: <AANLkTi=w1Ge_JV41dvj1uaoFBo=UfX4ZtuHT=G6Kx1dF@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
 <1287406015.29097.1579.camel@twins> <20101018133502.GA12449@n2100.arm.linux.org.uk>
 <1287409417.29097.1598.camel@twins> <tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
 <1287415929.29097.1616.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44088 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab0JRPgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 11:36:10 -0400
In-Reply-To: <1287415929.29097.1616.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 18, 2010 at 5:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Sure, but you can 'easily' extend your coherency protocols with support

In our case, there are no coherency protocols supported between the
A9, M3 and the DSP.
