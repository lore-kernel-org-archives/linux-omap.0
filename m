From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [spi-devel-general] SPI troubles
Date: Mon, 15 Mar 2010 08:38:38 -0700 (PDT)
Message-ID: <4b9e547e.0e1abc0a.1a65.ffff9e7e@mx.google.com>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
	<1b68c6791003141955q41ad6528y25faa5597dcbf9b3@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58599 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab0COPim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 11:38:42 -0400
Received: by bwz1 with SMTP id 1so3015802bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 08:38:40 -0700 (PDT)
In-Reply-To: <1b68c6791003141955q41ad6528y25faa5597dcbf9b3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

Thanks for your reply!

On Mon, 15 Mar 2010 11:55:56 +0900, jassi brar <jassisinghbrar@gmail.com> wrote:
> a) You might as well want to verify your SPIDEV setup by using the same pins
> in GPIO mode and controlling them by gpio-bitbanging i/f  ... first on both
> boards and then on either, to more accurately diagnose the problem). 

I have already attempted this, unfortunately. As I pointed out in my first
email, I have failed to get gpio-spi to do anything useful. I'm currently
struggling even to get it to output data, much less read.

> b) Maybe line-strength settings should be checked, if available, of the
> relevant pins?

Please clarify? According to my scope, the signals are picture-perfect. Any
further ideas you might have would be great appreciated. Thanks again,

- Ben

