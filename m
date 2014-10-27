From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Tue, 28 Oct 2014 01:01:38 +0200
Message-ID: <20141027230138.GB7805@drone.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:58695 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaJ0XCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Oct 2014 19:02:04 -0400
Content-Disposition: inline
In-Reply-To: <20141027200008.GR2560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> +
> +	if (!of_have_populated_dt())
> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> +

Maybe use WARN so that the warning is more verbose and kernel gets tainted?

A.
