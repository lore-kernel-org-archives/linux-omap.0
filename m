Return-Path: <SRS0=rl2H=4I=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF12C11D0C
	for <linux-omap@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4863320722
	for <linux-omap@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBTRxi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:38 -0500
Received: from muru.com ([72.249.23.125]:56414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgBTRxi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:38 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1D55F8080;
        Thu, 20 Feb 2020 17:54:23 +0000 (UTC)
Date:   Thu, 20 Feb 2020 09:53:35 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: dra7-l4: mark timer13-16 as pwm capable
Message-ID: <20200220175335.GP37466@atomide.com>
References: <20200219162126.28671-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219162126.28671-1-grygorii.strashko@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [200219 08:22]:
> DMTimers 13 - 16 are PWM capable and also can be used for CPTS input
> signals generation. Hence, mark them as "ti,timer-pwm".

Applying into fixes thanks.

Tony
