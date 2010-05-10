From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
Date: Mon, 10 May 2010 21:15:07 +0300
Message-ID: <20100510181507.GA32540@nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
 <1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
 <20100510111259.GA14680@linux-sh.org>
 <20100510125440.GA31721@nokia.com>
 <20100510130809.GC11804@besouro.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20944 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab0EJSRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 14:17:10 -0400
Content-Disposition: inline
In-Reply-To: <20100510130809.GC11804@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, ext Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, Ambresh <a0393775@ti.com>

On Mon, May 10, 2010 at 03:08:09PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
>I'm not aware of the module parameter stuff.. but the leak might be other thing
>than kstrdup?

yeah, I was following the code and the problem is how the kernel handles 
charp module parameters

-- 
balbi

DefectiveByDesign.org
