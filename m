From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
Date: Thu, 23 Jul 2015 13:35:53 +0100
Message-ID: <20150723123553.GE7576@n2100.arm.linux.org.uk>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437612483-30160-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel wrote:
> Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file results
> in one option less to think about when configuring the kernel.

> -#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> +#ifdef CONFIG_ARM_ERRATA_430973
>  	teq	r3, #0x00100000			@ only present in r1p*
>  	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
>  	orreq	r0, r0, #(1 << 6)		@ set IBE to 1

NAK.  Please read the mailing list history, I'm not repeating myself
again on this.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
