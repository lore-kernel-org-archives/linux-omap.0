From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
	changes
Date: Thu, 12 Jan 2012 21:00:55 +0000
Message-ID: <20120112210055.GD16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk> <20120112201112.GB16726@n2100.arm.linux.org.uk> <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com> <20120112202712.GC16726@n2100.arm.linux.org.uk> <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56876 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab2ALVBH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 16:01:07 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 09:32:40PM +0100, Shilimkar, Santosh wrote:
> OK. Point taken.

Can you also explain this in the code:

	size = ALIGN(PAGE_SIZE, SZ_1M);

Isn't that just SZ_1M written in a rather complex way?  A comment may be
a better way of explaining it.
