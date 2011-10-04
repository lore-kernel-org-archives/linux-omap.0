From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
Date: Tue, 4 Oct 2011 11:54:15 -0700
Message-ID: <20111004185415.GV6324@atomide.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
 <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314Ab1JDSyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 14:54:18 -0400
Content-Disposition: inline
In-Reply-To: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Vishwanath BS <vishwanath.bs@ti.com> [111004 10:25]:
> @@ -105,7 +105,7 @@ static void omap3_enable_io_chain(void)
>  		/* Do a readback to assure write has been done */
>  		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>  
> -		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> +		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
>  			 OMAP3430_ST_IO_CHAIN_MASK)) {
>  			timeout++;
>  			if (timeout > 1000) {

Checking for PM_WKST here makes sense..

> @@ -114,7 +114,7 @@ static void omap3_enable_io_chain(void)
>  				return;
>  			}
>  			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKEN);
> +					     WKUP_MOD, PM_WKST);
>  		}
>  	}
>  }

..but are you sure you also want to write into PM_WKST?

Tony
