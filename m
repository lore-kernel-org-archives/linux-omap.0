From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] OMAP3: PM: Smartreflex IP update changes for
 OMAP3630
Date: Mon, 8 Mar 2010 20:12:14 +0200
Message-ID: <20100308181213.GB6630@gandalf>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
 <1268068851-30022-3-git-send-email-thara@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38327 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0CHSL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 13:11:59 -0500
Content-Disposition: inline
In-Reply-To: <1268068851-30022-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

On Mon, Mar 08, 2010 at 10:50:50PM +0530, Thara Gopinath wrote:
> +static inline int sr_type(void)
> +{
> +	if (cpu_is_omap3630())
> +		return SR_TYPE_V2;
> +	else if (cpu_is_omap343x())
> +		return SR_TYPE_V1;
> +	else {
> +		pr_err("Trying to enable SR for Chip not support SR! \n");
> +		return 0;
> +	}

if one branch has curly braces, all of them should have. Check
Documentation/CodingStyle.

-- 
balbi
