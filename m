Return-Path: <SRS0=uib+=CT=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A7C433E2
	for <linux-omap@archiver.kernel.org>; Thu, 10 Sep 2020 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14D621D40
	for <linux-omap@archiver.kernel.org>; Thu, 10 Sep 2020 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIJJnu (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:43:50 -0400
Received: from muru.com ([72.249.23.125]:44482 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgIJJnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 10 Sep 2020 05:43:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E4DB880F9;
        Thu, 10 Sep 2020 09:43:31 +0000 (UTC)
Date:   Thu, 10 Sep 2020 12:44:09 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: n9, n950: Remove nokia,nvm-size property
Message-ID: <20200910094409.GA7101@atomide.com>
References: <20200904065811.9312-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904065811.9312-1-sakari.ailus@linux.intel.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@linux.intel.com> [200904 10:02]:
> Remove nokia,nvm-size property as it is no longer needed. The driver can
> nowadays figure out the size so do not specify it in DT.

Thanks applying into omap-for-v5.10/dt.

Regards,

Tony
