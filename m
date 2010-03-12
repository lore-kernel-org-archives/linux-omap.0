From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 18/19] omap: Add DSI regulator supply to OMAP3EVM board
	file
Date: Thu, 11 Mar 2010 16:06:51 -0800
Message-ID: <20100312000651.GZ2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311235958.GX2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100311235958.GX2900@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100311 15:55]:
> From 9c7ceeb2621349f180be4779d954352bcc8df9cd Mon Sep 17 00:00:00 2001
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> Date: Thu, 11 Mar 2010 08:55:17 +0000
> Subject: [PATCH] omap: Add DSI regulator supply to OMAP3EVM board file
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface, it
> is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> fails to get regulator.

Oops, had to manually send the last two messages.. This is already
at 17/18, so please ignore.

Regards,

Tony
