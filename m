From: David Brownell <david-b@pacbell.net>
Subject: Re: new PM branch available
Date: Wed, 14 Jan 2009 10:09:27 -0800
Message-ID: <200901141009.28089.david-b@pacbell.net>
References: <87iqoij2me.fsf@deeprootsystems.com> <84166B96-7874-4B6D-B86E-659250F62558@student.utwente.nl>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:20637 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752682AbZANSJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 13:09:30 -0500
In-Reply-To: <84166B96-7874-4B6D-B86E-659250F62558@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tuesday 13 January 2009, Koen Kooi wrote:
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock.c:1094 omap2_clk_register 
> +0x24/0x3c()
> Modules linked in:
> [<c003b824>] (dump_stack+0x0/0x14) from [<c005b180>] (warn_on_slowpath 
> +0x4c/0x68)

Just in the cause of better diagnostics ... that looks like maybe

        if (!clk->clkdm.name) {
                pr_debug("clock: %s: missing clockdomain", clk->name);
                WARN_ON(1);
                return -EINVAL;
        }

triggered.  A better way to write that, in recent kernels, is

	if (WARN(!clk->clkdm.name,
			"clock: %s missing clockdomain\n", clk->name))
		return -EINVAL;

Where "better" includes "diagnostic message is always present"
and thus "line numbers matter less".  (Line 1094 in my kernel
is the right bracket above, not the WARN_ON...)

- Dave
