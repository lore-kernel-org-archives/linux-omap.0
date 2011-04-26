From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [Regression?] Removed regulator support in ehci-omap
Date: Tue, 26 Apr 2011 11:27:40 +0530
Message-ID: <f9a61e8afd447ee21b7d4a2744e15d59@mail.gmail.com>
References: <20110411093214.GA18215@rainbow><4DA3350E.2060400@gmail.com><BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com><112ef82aebc719ef25cde126f2014ebc@mail.gmail.com><20110412040420.GB25239@rainbow><bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com><4DB0D58E.4030508@signal11.us><8712165194c49f0b4d8c1bd1fe717b8a@mail.gmail.com><4DB58108.4040708@signal11.us>
 <BANLkTinn7C2gVKg4v8dbUxo7yYycdFM8PA@mail.gmail.com> <0e9c63ec5ebfd57af1ac3318e436efb9@mail.gmail.com>
 <4DB5ADFF.5030502@gmail.com> <4DB601FB.3000306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34854 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754351Ab1DZF6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 01:58:04 -0400
In-Reply-To: <4DB601FB.3000306@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Alan Ott <alan@signal11.us>, Dmitry Artamonow <mad_soft@inbox.ru>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

> Hi Keshava,
>
> I rebuilt my system to boot from flash and now I see what happened. I
> even remember it being discussed on this list. Someone renamed my usb
> ethernet device from usb0 to eth0 !!! The boot log shows it on this
line:
>
> > [    4.596130] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
> > usb-ehci-omap.0d
>
>
> So this broke my init scripts and uboot script... OK, so I can live with
> this (I hope the name doesn't change too often though).
>
> So I can manually configure my system to use eth0 and use the network. I
> am sure I will get nfs working shortly.
>
> I am using the 2.6.39-rc4 with your 3 patches. So from the Beagleboard
> XM perspective it works and you can include my
>
> Tested-by: Steve Calfee <stevecalfee@gmail.com>

Thanks Steve

Keshava Munegowda
