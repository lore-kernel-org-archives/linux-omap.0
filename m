From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: CPU_IDLE causes random reboots on custom 4430
Date: Sat, 22 Sep 2012 11:15:48 +0530
Message-ID: <CAMQu2gwwU2QYAmn+WY19t5krOJeEUF7YT03FojLbQcfo3h4BmQ@mail.gmail.com>
References: <505CEEFD.1080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:43900 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753140Ab2IVFqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Sep 2012 01:46:10 -0400
Received: by vcbfo13 with SMTP id fo13so4747792vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 22:46:08 -0700 (PDT)
In-Reply-To: <505CEEFD.1080507@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hoffmann <chrmhoffmann@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sat, Sep 22, 2012 at 4:19 AM, Chris Hoffmann <chrmhoffmann@gmail.com> wrote:
> Hi,
>
> We're trying to get a custom 4430 board (aka. nook tablet with OMAP4430
> ES2.3 HS TWL6030 ES2.1) working with p-android-omap-3.0 on android jelly
> bean. The board works quite well, but we experience random hangs and the
> watchdog kicks the board to reboot.
>
On the same kernel, you should have support for the persistent log. You might
want to check the output. That should give you pointers on what CPU was
doing before the freeze which resulted in reboot.

Regards
Santosh
