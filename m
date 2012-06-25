From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1 v2] ARM: only call smp_send_stop() on SMP
Date: Mon, 25 Jun 2012 09:49:05 +0100
Message-ID: <20120625084905.GD19226@n2100.arm.linux.org.uk>
References: <1340533690-4049-1-git-send-email-javier@dowhile0.org> <20120625005134.GA2342@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33072 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab2FYItQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 04:49:16 -0400
Content-Disposition: inline
In-Reply-To: <20120625005134.GA2342@S2101-09.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 25, 2012 at 08:51:37AM +0800, Shawn Guo wrote:
> It seems the same patch has been there for a while.
> 
> http://thread.gmane.org/gmane.linux.kernel/1303115

Bah, why doesn't stuff like this get resent if nothing has happened for
a while?
