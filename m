Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B132C001E0
	for <linux-omap@archiver.kernel.org>; Wed,  9 Aug 2023 07:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHIH2R (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Aug 2023 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjHIH2A (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Aug 2023 03:28:00 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A51FF271C;
        Wed,  9 Aug 2023 00:27:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1819D8105;
        Wed,  9 Aug 2023 07:27:22 +0000 (UTC)
Date:   Wed, 9 Aug 2023 10:27:20 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Dhruva Gole <d-gole@ti.com>, linux-omap@vger.kernel.org,
        Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] bus: ti-sysc: Fix build warning for 64-bit build
Message-ID: <20230809072720.GC11676@atomide.com>
References: <20230804103859.57458-1-tony@atomide.com>
 <20230805051753.vpwhg52zttpbbntx@dhruva>
 <20230805172325.4vjb4lb3vtu3dgfe@commodity>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805172325.4vjb4lb3vtu3dgfe@commodity>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230805 17:23]:
> On 10:47-20230805, Dhruva Gole wrote:
> > On Aug 04, 2023 at 13:38:57 +0300, Tony Lindgren wrote:
> > >  	match = soc_device_match(sysc_soc_match);
> > >  	if (match && match->data)
> > > -		sysc_soc->soc = (int)match->data;
> > > +		sysc_soc->soc = (unsigned long)match->data;
> > 
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
> Dumb q: is'nt this an enum? Is it better to cast it as (enum
> sysc_soc)match->data ?

Good idea, will update.

Regards,

Tony
