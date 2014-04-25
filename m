From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 10/13] tty: serial: omap: remove some dead code
Date: Fri, 25 Apr 2014 12:40:17 +0100
Message-ID: <20140425124017.6fbcb971@alan.etchedpixels.co.uk>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
	<1398265117-11793-10-git-send-email-balbi@ti.com>
	<5357DDA8.4040206@ti.com>
	<20140424084305.20c7f301@notabene.brown>
	<20140423230121.GC10924@saruman.home>
	<20140424101329.02e6a62f@notabene.brown>
	<20140424012100.GB13374@saruman.home>
	<20140424151914.6bc6463a@alan.etchedpixels.co.uk>
	<20140425193412.7d32e429@notabene.brown>
	<CAGm1_kvSEcXRGoQrUoJcmFq6gTHkjupzDqesw3cTmL=V74yPOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGm1_kvSEcXRGoQrUoJcmFq6gTHkjupzDqesw3cTmL=V74yPOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: NeilBrown <neilb@suse.de>, balbi@ti.com, Nishanth Menon <nm@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org, johan.hedberg@gmail.com, jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

> As soon as this patch
> (http://www.spinics.net/lists/arm-kernel/msg325197.html) will be
> applied, we don't really need this DTR GPIO any more.

For the omap specific case, not for the general case of sorting out power
hierarchies.

Alan
