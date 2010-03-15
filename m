From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [spi-devel-general] SPI troubles
Date: Mon, 15 Mar 2010 11:55:56 +0900
Message-ID: <1b68c6791003141955q41ad6528y25faa5597dcbf9b3@mail.gmail.com>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42108 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0COCz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Mar 2010 22:55:56 -0400
Received: by vws12 with SMTP id 12so31229vws.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Mar 2010 19:55:56 -0700 (PDT)
In-Reply-To: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Mon, Mar 15, 2010 at 11:44 AM, Ben Gamari <bgamari.foss@gmail.com> wrote:
> While I can reliably see a signal sent on the SIMO line, I have not once been
> able to recieve anything but zeros in return. I have verified that the the SOMI
> ball works as expected as a GPIO input.
a) You might as well want to verify your SPIDEV setup by using the
same pins in GPIO mode
and controlling them by gpio-bitbanging i/f  ... first on both boards
and then on either, to more
accurately diagnose the problem).
b) Maybe line-strength settings should be checked, if available, of
the relevant pins?

hth
