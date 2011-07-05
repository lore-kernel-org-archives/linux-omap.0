From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: omap4: rename gpmc clock to gpmc_ick
Date: Tue, 05 Jul 2011 11:35:00 -0700
Message-ID: <87oc18r2y3.fsf@ti.com>
References: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>
	<4E1340AA.2020007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50702 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752487Ab1GESfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 14:35:04 -0400
Received: by mail-pz0-f44.google.com with SMTP id 5so2484580pzk.31
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 11:35:03 -0700 (PDT)
In-Reply-To: <4E1340AA.2020007@ti.com> (Santosh Shilimkar's message of "Tue,
	05 Jul 2011 09:49:46 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Jan Weitzel <j.weitzel@phytec.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> + Benoit
>
> On 7/5/2011 5:19 AM, Jan Weitzel wrote:
>> The gpmc clock on omap44xx is called gpmc_ick not gpmc_ck in
>> clock44xx_data.c
>>
>> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> This happened after renaming the clock-nodes some time back.
> Looks good to me as a fix though in long run GPMC should be
> moved to hwmod to avoid such naming issues

In fact, Benoit has already done it[1] as part of his last series:
[PATCH v2 0/4] OMAP4: Add modulemode support to hwmod framework (part 2)

Kevin

[1] http://marc.info/?l=linux-omap&m=130955728217211&w=2
