From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [BUG?] drivers: net:ethernet: cpsw: add support for VLAN
Date: Fri, 24 Apr 2015 11:27:06 +0530
Message-ID: <5539DB32.3050203@ti.com>
References: <1429741702.29353.28.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49189 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbbDXF5e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 01:57:34 -0400
In-Reply-To: <1429741702.29353.28.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: chf.fritz@googlemail.com, Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 23 April 2015 03:58 AM, Christoph Fritz wrote:
> Hi,
> 
>  has commit 3b72c2fe0c6bbec42e ("drivers: net:ethernet: cpsw: add
> support for VLAN") introduced a bug by defining CPSW_VLAN_AWARE as
> BIT(1) instead of BIT(2)?
> 
> +#define CPSW_VLAN_AWARE		BIT(1)
> <snip>
>  	/* switch to vlan unaware mode */
> -	cpsw_ale_control_set(priv->ale, 0, ALE_VLAN_AWARE, 0);
> +	cpsw_ale_control_set(priv->ale, priv->host_port, ALE_VLAN_AWARE,
> +			     CPSW_ALE_VLAN_AWARE);
> +	control_reg = readl(&priv->regs->control);
> +	control_reg |= CPSW_VLAN_AWARE;
> +	writel(control_reg, &priv->regs->control);
> 
> See TRM [1] page 1980 (14.5.1.2 CONTROL Register), there bit
> CPSW_VLAN_AWARE is number 2.
> 
> I didn't do any tests, just stumbled upon.
> 
> [1]: http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf
> 

Its bug in TRM, will check with TRM team and update here.

Regards
Mugunthan V N

