From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: regression: Clock changes in next-20141205 break at least omap4
Date: Tue, 16 Dec 2014 11:01:02 -0800
Message-ID: <5490816E.7060706@codeaurora.org>
References: <20141205165539.GA30437@atomide.com> <5481F79D.4010504@codeaurora.org> <20141205183849.GB30437@atomide.com> <20141212194238.20398.33333@quantum> <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com> <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com> <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:57014 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaLPTBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 14:01:05 -0500
In-Reply-To: <548F8B70.2060803@nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <pwalmsley@nvidia.com>, Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, khilman@linaro.org

On 12/15/2014 05:31 PM, Paul Walmsley wrote:
>
> I just took a quick glance at Tero's second patch, and it looks like a
> hack to me.  Better to fix the problem in the core CCF code if
> possible.  I don't think there's any reason why a PLL couldn't have
> just one parent clock.  But I'm fine with merging it as a short-term
> fix if fixing the core code is difficult or risky.

Can you describe what's wrong? Does the PLL have a mux with two inputs
that map to the same clock?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

