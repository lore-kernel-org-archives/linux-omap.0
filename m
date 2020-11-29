Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7979C64E7B
	for <linux-omap@archiver.kernel.org>; Sun, 29 Nov 2020 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7599207BC
	for <linux-omap@archiver.kernel.org>; Sun, 29 Nov 2020 21:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgK2VzI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 29 Nov 2020 16:55:08 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40296 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgK2VzI (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sun, 29 Nov 2020 16:55:08 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 61BBD2002C;
        Sun, 29 Nov 2020 22:54:21 +0100 (CET)
Date:   Sun, 29 Nov 2020 22:54:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     trix@redhat.com
Cc:     b.zolnierkie@samsung.com, pakki001@umn.edu,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] omapfb: fbcon: remove trailing semicolon in macro
 definition
Message-ID: <20201129215420.GE1162850@ravnborg.org>
References: <20201127190508.2842786-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127190508.2842786-1-trix@redhat.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8 a=lSec57_JDs9yAHf9QvQA:9
        a=CjuIK1q_8ugA:10 a=HngZt1h-djAA:10
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Tom,
On Fri, Nov 27, 2020 at 11:05:08AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks, applied to drm-misc-next.

	Sam
