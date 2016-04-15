From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dflt: remove redundant unlikely
Date: Fri, 15 Apr 2016 15:53:21 -0700
Message-ID: <20160415225321.GA14441@codeaurora.org>
References: <1459880937-22349-1-git-send-email-s-anna@ti.com>
 <1459891815.6715.15.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459891815.6715.15.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/05, Joe Perches wrote:
> 
> There are several of these:
[...]
> 
> Maybe a new checkpatch test like:

Looks good to me.
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
