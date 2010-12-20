From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Is changing serial from /dev/ttySx to /dev/ttyOx a good idea?
Date: Mon, 20 Dec 2010 11:04:14 +0800
Message-ID: <AANLkTi=P58XerK8jdyvfT9JS6tU3U11tYP=KH4_B-cn=@mail.gmail.com>
References: <201012201546.12319.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35614 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0LTDEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 22:04:16 -0500
Received: by wyb28 with SMTP id 28so2449343wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 19:04:14 -0800 (PST)
In-Reply-To: <201012201546.12319.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: linux-omap@vger.kernel.org

Hi,

2010/12/20 Charles Manning <manningc2@actrix.gen.nz>:
> Hi All
>
> With the change to the new omap-serial stuff, the device names have changed
> from /dev/ttySn to /dev/ttyOn.
>
> Using the "fit/form/function" argument, this would seem to be a bad idea.
>
> The kernel does not exist in a vacuum. It is surrounded by u-boot scripts,
> command line options, init scripts etc etc. Flipping back and forth between
> 2.6.36 and 2.6.37 kernels for testing purposes needs these to be changed.
> Annoying and anti-productive.
>
> Isn't it just better to just replace the ttyOn name with ttyS. That would make
> a far smoother transition.
>
> Thoughts?

In fact, the transition is not friendly indeed for a user. I don't know why
the transition is introduced, for what purpose? Who can give a explanation?

thanks,
-- 
Lei Ming
