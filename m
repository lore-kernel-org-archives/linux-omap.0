From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: serial-omap regression?
Date: Fri, 21 Sep 2012 14:49:58 -0700
Message-ID: <87d31fdp15.fsf@deeprootsystems.com>
References: <87wqzofgms.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56268 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab2IUVuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 17:50:00 -0400
Received: by pbbrr4 with SMTP id rr4so3482779pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 14:49:59 -0700 (PDT)
In-Reply-To: <87wqzofgms.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Thu, 20 Sep 2012 15:56:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Not sure if it's related to the cleanup series, but I've also been
seeing a bunch of 'callbacks suppressed messages lately.  Is anyone else
seeing this?

Here's an example from a debian nfsfroot boot:

[   20.044006] tty_init_dev: 59 callbacks suppressed
[   25.063934] tty_init_dev: 57 callbacks suppressed
[   38.910552] tty_init_dev: 38 callbacks suppressed

Kevin
