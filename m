From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: am35x: fix compile error due to control apis
Date: Sat, 4 Dec 2010 19:23:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE39EFF@dbde02.ent.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <73b778ec731792828bed71d9e801da79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab0LDNxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 08:53:11 -0500
In-Reply-To: <73b778ec731792828bed71d9e801da79@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

> > As the control.h have been moved to new location and it's
> > uses are not allowed to drivers directly so moving the phy
> > control, interrupt clear and reset functionality to board
> > files.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > ---
> > Patch created against today's linus tree.
> 
> I hope this is a short-term fix only; otherwise you will need
> to duplicate this code in all boards that use an AM3517.

most of the stuff are in usb-musb.c so can be reused by all the boards.
Only the musb reset part is added in board file.

Ajay
> 
> - Anand
