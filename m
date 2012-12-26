From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2 0/2] cpts fixes for v3.8-rc2
Date: Wed, 26 Dec 2012 09:42:28 +0530
Message-ID: <50DA792C.1070603@ti.com>
References: <cover.1356331925.git.richardcochran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53374 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145Ab2LZEPI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Dec 2012 23:15:08 -0500
In-Reply-To: <cover.1356331925.git.richardcochran@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, David Miller <davem@davemloft.net>, Cyril Chemparathy <cyril@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

On 12/24/2012 12:49 PM, Richard Cochran wrote:
> Changed in v2:
> Use clk_prepare_enable instead of clk_prepare + clk_enable.
>
> The new cpts driver has two small issues, but it otherwise seems to be
> working in -rc1.
>
> Thanks,
> Richard
>
> Richard Cochran (2):
>    cpts: fix build error by removing useless code.
>    cpts: fix a run time warn_on.
>
>   drivers/net/ethernet/ti/cpts.c |    3 +--
>   drivers/net/ethernet/ti/cpts.h |    1 -
>   2 files changed, 1 insertions(+), 3 deletions(-)
>
Looks good to me.
Acked-by : Mugunthan V N <mugunthanvnm@ti.com>
