From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] arm: perf: Fix build break due to a typo
Date: Thu, 14 Oct 2010 18:23:12 +0200
Message-ID: <20101014162312.GA24972@elte.hu>
References: <1287066841-28569-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287066841-28569-1-git-send-email-gadiyar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, paulus <paulus@samba.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org


* Anand Gadiyar <gadiyar@ti.com> wrote:

> armpmu is a pointer to a structure - We need to use the structure 
> pointer operator to access num_events, and not the structure member 
> operator.
> 
> This fixes the following build break when building for OMAP4.

Yeah - i already fixed it earlier today and pushed it out.

Thanks,

	Ingo
