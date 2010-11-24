From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: UART: don't resume UARTs that are not enabled.
Date: Wed, 24 Nov 2010 14:35:16 -0800
Message-ID: <20101124223516.GX31536@atomide.com>
References: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
 <1290631720.15533.30.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64853 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0KXWfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 17:35:22 -0500
Content-Disposition: inline
In-Reply-To: <1290631720.15533.30.camel@eowin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj R." <govindraj.raja@ti.com>

* Felipe Balbi <me@felipebalbi.com> [101124 12:39]:
> Hi,
> 
> On Wed, 2010-11-24 at 11:09 -0800, Kevin Hilman wrote:
> > Add additional check to omap_uart_resume_idle() so that only
> > enabled (specfically, idle-enabled) UARTs are allowed to resume.
> 
> typo: specifically

Also, without this patch, system with PM enabled hangs in
cases where only one serial port is initialized instead of
all of them. So I'll queue it as a fix during the -rc cycle.

Regards,

Tony
