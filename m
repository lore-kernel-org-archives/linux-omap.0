From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] clk: fix compile for OF && !COMMON_CLK
Date: Tue, 17 Jul 2012 19:04:13 +0530
Message-ID: <500569D5.3020508@ti.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com> <20120717001228.GA28886@gmail.com> <5004C935.4050707@gmail.com> <50056648.6000906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:58271 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116Ab2GQNeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 09:34:21 -0400
Received: by obbeh20 with SMTP id eh20so518615obb.10
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 06:34:19 -0700 (PDT)
In-Reply-To: <50056648.6000906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mike Turquette <mturquette@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, aletes.xgr@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, loml <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Tuesday 17 July 2012 06:49 PM, Rajendra Nayak wrote:
> struct clk *clk_get(struct device *dev, const char *con_id)
> {
>          const char *dev_id = dev ? dev_name(dev) : NULL;
>          struct clk *clk;
>
>          if (dev) {
> ---->
>      Any reason why this isn't
>      if (dev->of_node) {
> ---->

Or rather,
	if (dev && dev->of_node) {
as Archit just pointed out to me.
