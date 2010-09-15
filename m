From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 17:56:57 +0800
Message-ID: <AANLkTim+d-DvOhajKxKL21ZOfWkyCSH3ywfw-01g2S0c@mail.gmail.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
	<1283873014-32511-6-git-send-email-tom.leiming@gmail.com>
	<4C8E18AD.8000502@ru.mvista.com>
	<AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
	<4C8E4882.6040600@ru.mvista.com>
	<4C8E50CC.3080705@ru.mvista.com>
	<20100914065604.GD2601@legolas.emea.dhcp.ti.com>
	<4C8F527E.40408@ru.mvista.com>
	<20100914105402.GD7554@legolas.emea.dhcp.ti.com>
	<4C8FB60D.1080906@ru.mvista.com>
	<20100915065345.GC3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41534 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab0IOJ5J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 05:57:09 -0400
In-Reply-To: <20100915065345.GC3393@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

2010/9/15 Felipe Balbi <balbi@ti.com>:
> if request->length == 1MB and dma->max_len = 128KB, when is_dma is true,
> request->actual will be different from request->length for 7
> 'iterations', then only on the 8th it will be the same. I believe that's
> what Ming is trying to fix.
>
> Ming, am I correct ?

Yes, it is the initial motivation of the patch.

-- 
Lei Ming
