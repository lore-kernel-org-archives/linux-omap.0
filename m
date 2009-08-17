From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Mon, 17 Aug 2009 15:51:20 +0300
Message-ID: <87d46uvc1j.fsf@litku.valot.fi>
References: <20090815174352.c2883585.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
	<20090815180701.7710de51.jhnikula@gmail.com>
	<20090815174000.GA13164@nokia.com>
	<20090816104415.e12a5e46.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:59891 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZHQMvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:51:24 -0400
In-Reply-To: <20090816104415.e12a5e46.jhnikula@gmail.com> (Jarkko Nikula's message of "Sun\, 16 Aug 2009 10\:44\:15 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: felipe.balbi@nokia.com, "Gadiyar, Anand" <gadiyar@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jarkko Nikula <jhnikula@gmail.com> writes:

> By some reason CONFIG_OMAP_LL_DEBUG_UART3=y and CONFIG_DEBUG_LL=y
> don't work in mainline so hard to trace what is make an oops.

You need to apply this patch manually:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=73e5b252eb179f601f2da2538ac3b70c21b2c6c2

-- 
Kalle Valo
