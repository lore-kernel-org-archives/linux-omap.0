From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/6] OMAP: powerdomain: Infrastructure to put arch
 specific code
Date: Tue, 16 Nov 2010 17:11:17 +0100
Message-ID: <20101116171117.46a13d0a@surf>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
	<1289921886-5139-2-git-send-email-rnayak@ti.com>
	<1289921886-5139-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45779 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab0KPQL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 11:11:28 -0500
In-Reply-To: <1289921886-5139-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com

On Tue, 16 Nov 2010 21:08:02 +0530
Rajendra Nayak <rnayak@ti.com> wrote:

> +struct pwrdm_functions {
> +	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8 pwrst);
> +	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8 pwrst);
> +	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
> +	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
> +	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8 bank);
> +	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
> +	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
> +};

It would probably be great to have some short documentation on this
structure, to detail what are the different operations, what they
should do, etc.

By the way, would pwrdm_operations be more linux-ish than
pwrdm_functions ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
