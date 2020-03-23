Return-Path: <SRS0=2jSD=5I=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F59C3F2CD
	for <linux-omap@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9733320781
	for <linux-omap@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgCWNug (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:50:36 -0400
Received: from foss.arm.com ([217.140.110.172]:49328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgCWNug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 23 Mar 2020 09:50:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7DB61FB;
        Mon, 23 Mar 2020 06:50:35 -0700 (PDT)
Received: from [10.37.12.102] (unknown [10.37.12.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855B83F52E;
        Mon, 23 Mar 2020 06:50:25 -0700 (PDT)
Subject: Re: [PATCH v5 5/5] drm/panfrost: Register devfreq cooling and attempt
 to add Energy Model
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com,
        patrick.bellasi@matbug.net, orjan.eide@arm.com,
        rdunlap@infradead.org, mka@chromium.org
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-6-lukasz.luba@arm.com> <20200318131114.GA1812@kevin>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4bc1cf2f-e5ea-6265-d685-167d7a92da56@arm.com>
Date:   Mon, 23 Mar 2020 13:50:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318131114.GA1812@kevin>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org



On 3/18/20 1:11 PM, Alyssa Rosenzweig wrote:
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Thank you Alyssa for the review.

Regards,
Lukasz
