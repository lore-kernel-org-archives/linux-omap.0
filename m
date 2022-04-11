Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3243C433EF
	for <linux-omap@archiver.kernel.org>; Mon, 11 Apr 2022 14:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiDKOEs (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 11 Apr 2022 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346884AbiDKOEq (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2022 10:04:46 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ED0432045;
        Mon, 11 Apr 2022 07:02:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 658FC809F;
        Mon, 11 Apr 2022 14:00:00 +0000 (UTC)
Date:   Mon, 11 Apr 2022 17:02:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Start managing serial controllers to
 enable runtime PM
Message-ID: <YlQ09mizfY8z5REh@atomide.com>
References: <20220411120218.17422-1-tony@atomide.com>
 <YlQsTWcM3is9TGdw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQsTWcM3is9TGdw@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [220411 13:26]:
> On Mon, Apr 11, 2022 at 03:02:18PM +0300, Tony Lindgren wrote:
> >  	unsigned char		hub6;			/* this should be in the 8250 driver */
> >  	unsigned char		suspended;
> >  	unsigned char		console_reinit;
> > +	unsigned long		supports_autosuspend:1;
> 
> Hmm... Maybe use unsigned char and convert all of them to something else if needed?

Sorry forgot to reply to this. This can be unsigned char no problem.
Most of the runtime PM related flags are in the struct serial_controller
anyways now.

Regards,

Tony



