Return-Path: <SRS0=JveC=7L=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3735C433DF
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995622067B
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 17:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE2RrR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 May 2020 13:47:17 -0400
Received: from muru.com ([72.249.23.125]:56208 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2RrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 29 May 2020 13:47:17 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EC3128030;
        Fri, 29 May 2020 17:48:07 +0000 (UTC)
Date:   Fri, 29 May 2020 10:47:14 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 7/8] ARM: OMAP2: Switch to use DEVICE_ATTR_RO()
Message-ID: <20200529174714.GU37466@atomide.com>
References: <20200523170859.50003-1-sudeep.holla@arm.com>
 <20200523170859.50003-8-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523170859.50003-8-sudeep.holla@arm.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [200523 17:10]:
> Move device attributes to DEVICE_ATTR_RO() as that would make things
> a lot more "obvious" what is happening over the existing __ATTR usage.

Acked-by: Tony Lindgren <tony@atomide.com>
