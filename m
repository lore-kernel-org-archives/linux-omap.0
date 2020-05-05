Return-Path: <SRS0=ZgCm=6T=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AEFC47256
	for <linux-omap@archiver.kernel.org>; Tue,  5 May 2020 18:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF24020721
	for <linux-omap@archiver.kernel.org>; Tue,  5 May 2020 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgEESOb (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 5 May 2020 14:14:31 -0400
Received: from muru.com ([72.249.23.125]:52924 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgEESOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 5 May 2020 14:14:30 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7F93F80A5;
        Tue,  5 May 2020 18:15:19 +0000 (UTC)
Date:   Tue, 5 May 2020 11:14:28 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/17] ARM: dts: dra7/am57xx: remoteproc support
Message-ID: <20200505181428.GO37466@atomide.com>
References: <20200424151244.3225-1-t-kristo@ti.com>
 <20200424155128.GK37466@atomide.com>
 <5f8d4dbb-f4fc-ee97-8542-610e98d3f895@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8d4dbb-f4fc-ee97-8542-610e98d3f895@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [200424 15:55]:
> On 24/04/2020 18:51, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [200424 08:13]:
> > > Hi Tony,
> > > 
> > > This series adds the DT nodes necessary for remoteproc support, now that
> > > the driver side changes are (mostly) in. Couple of things to note
> > > though.
> > > 
> > > 1) There is a new IOMMU issue, for which I posted a fix today [1]
> > > 2) The remoteproc core still has an issue for which there is ongoing
> > >     discussion [2]
> > > 
> > > With these two issue taken care of, the omap remoteproc support is
> > > functional. The question though is, whether we should just wait until
> > > the above two issues are resolved and merge the DT patches post that, or
> > > merge the DT patches with status = "disabled".
> > 
> > If there are no dependencies between the pending driver fixes and
> > the dts changes I see no reason to not merge the dts changes.
> 
> Yeah, no hard dependencies as such, just that things won't work properly
> before they are in.

Applying these all into omap-for-v5.8/dt thanks.

Tony
