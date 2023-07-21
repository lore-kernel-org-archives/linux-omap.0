Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCDEB64DC
	for <linux-omap@archiver.kernel.org>; Fri, 21 Jul 2023 06:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGUGAH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 21 Jul 2023 02:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUGAG (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jul 2023 02:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDCE62;
        Thu, 20 Jul 2023 23:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B855261013;
        Fri, 21 Jul 2023 06:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CF0C433C8;
        Fri, 21 Jul 2023 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919202;
        bh=zu9FYK43ofiPCrMrbpw4Rr/H/foM7pthBpajMqQAoe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZftGg7slPKtwO0TDo885FC8rgAIqGhp7dey9vASKtdNKchTRiNVzRsl3VdoV4D1jQ
         2Y429gDVZdkge4vhGNUsb9pu30NqE9qZWu0C+/eTXYRkaCkW/kPD21PPy9sCUb2bT/
         46OEvBC8yKo4v/Q7VwMcvkkvMXWx+975VebvOGnM=
Date:   Fri, 21 Jul 2023 08:00:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <2023072144-splurge-debate-e681@gregkh>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721054326.GO5194@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Jul 21, 2023 at 08:43:26AM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230720 19:33]:
> > On Thu, Jul 20, 2023 at 08:10:14AM +0300, Tony Lindgren wrote:
> > > The controller id cannot be negative.
> > > 
> > 
> > What does this mean for a changelog?
> 
> Just let's fix it while at it and adding port_id in the following patch.
> If you prefer I can squash the change into the fix adding port_id.

A separate patch like this is fine, just properly document it please :)

thanks,

greg k-h
