From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] ARM: OMAP: fix cpufreq build
Date: Thu, 15 Mar 2012 12:47:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203151247220.7108@utopia.booyaka.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk> <E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk> <87aa3hdc3o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87aa3hdc3o.fsf@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Dave Jones <davej@redhat.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 15 Mar 2012, Kevin Hilman wrote:

> Initially, this was intended as a cleanup because it was just dead code
> removal, but since we missed v3.4, maybe we should pull out 
> "ARM: OMAP: clock: cleanup CPUfreq leftovers" and submit for 3.4-rc.

If it doesn't go upstream for the 3.4 merge window, I'll submit it for 
3.4-rc.


- Paul
