From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] cpts fixes for v3.8-rc2
Date: Wed, 26 Dec 2012 14:15:40 -0800 (PST)
Message-ID: <20121226.141540.163930025578455864.davem@davemloft.net>
References: <cover.1356331925.git.richardcochran@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35457 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2LZWPw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 17:15:52 -0500
In-Reply-To: <cover.1356331925.git.richardcochran@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, cyril@ti.com, mugunthanvnm@ti.com, sshtylyov@mvista.com

From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 24 Dec 2012 08:19:08 +0100

> Changed in v2:
> Use clk_prepare_enable instead of clk_prepare + clk_enable.
> 
> The new cpts driver has two small issues, but it otherwise seems to be
> working in -rc1.

Both applied, thanks.
