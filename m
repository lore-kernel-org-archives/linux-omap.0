Return-Path: <SRS0=dbTE=B6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE6C433DF
	for <linux-omap@archiver.kernel.org>; Thu, 20 Aug 2020 04:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7AC2054F
	for <linux-omap@archiver.kernel.org>; Thu, 20 Aug 2020 04:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgHTEYF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:24:05 -0400
Received: from muru.com ([72.249.23.125]:41218 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgHTEYE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 20 Aug 2020 00:24:04 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C557C807A;
        Thu, 20 Aug 2020 04:24:02 +0000 (UTC)
Date:   Thu, 20 Aug 2020 07:24:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     maemo-leste@lists.dyne.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz
Subject: Re: GPS fun on Droid 4 and leste
Message-ID: <20200820042431.GI2994@atomide.com>
References: <20200712092726.GC13495@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712092726.GC13495@amd>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200712 09:28]:
> Hi!
> 
> GPS on the droid 4 does not really work out of the box.
> 
> gpsd is not in default installation, maybe it should be?
> 
> What is worse, there's something broken with gpsd. Try:
> 
> /usr/sbin/gpsd -N -D 5 /dev/gnss0
> gpspipe -w
> # this seems to work, but do ^C and restart
> gpspipe -w
> ...and it hangs.

Some earlier versions of gpsd I think had issues where you could
only connect one client. Or it was a bug in the kernel drivers..
Anyways, multiple gpspipe instances have been working for me for
a while now with gpsd-3.21.

I also found some issues in gnss-motmdm driver for closing the
gnss device, see:

https://github.com/tmlind/linux/commits/droid4-pending-v5.8

And I think the xtra2.bin data for agps is now working too :)

https://github.com/tmlind/droid4-agps/commits/master

At least I now get a fix in about two minutes after running the
update.sh, going outside, and starting cgps.

> xgps from gpsd-clients is broken: probably missing dependency
> on gtk3 libraries.
> 
> user@devuan-droid4:/my/tui/lib$ xgps
> Traceback (most recent call last):
>   File "/usr/bin/xgps", line 30, in <module>
>       gi.require_version('Gtk', '3.0')
>  File "/usr/lib/python2.7/dist-packages/gi/__init__.py", line
>  129, in require_version
>  raise ValueError('Namespace %s not available' % namespace)
>  ValueError: Namespace Gtk not available
> 
> Any ideas?

No idea about the xgps related stuff, I mostly use cgps for
testing with GPSD_UNITS=metric cgps.

Regards,

Tony
