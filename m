From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
Date: Mon, 27 Jul 2015 11:43:41 +0100
Message-ID: <20150727104341.GG7576@n2100.arm.linux.org.uk>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
 <20150724001605.GA1453@earth>
 <20150726225145.GF7576@n2100.arm.linux.org.uk>
 <20150727011447.GA23087@earth>
 <55B6011C.9070906@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B6011C.9070906@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 27, 2015 at 10:59:56AM +0100, Ben Dooks wrote:
> This isn't the only place ARM_ERRATA_430973 is used, and if
> you make it configurable on !ARCH_MULTIPLATFORM then it makes
> it impossible to use a ARCH_MULTIPLATFORM kernel on something
> that is an Cortex-A8.
> 
> See arch/arm/mm/proc-v7-2level.S

That has been fixed so that the BTAC/BTB always gets flushed on each
context switch for all Cortex-A8 CPUs, but none of the other v7 CPUs.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
