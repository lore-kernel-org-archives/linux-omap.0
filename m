From: Peter Barada <peterb@logicpd.com>
Subject: RE: Missing USB OTG ID interrupt../
Date: Tue, 13 Jan 2009 02:25:45 -0500
Message-ID: <1231831546.14918.35.camel@blackhole>
References: <1231789145.14918.31.camel@blackhole>
	 <19F8576C6E063C45BE387C64729E739403ECF70A80@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:16624 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753150AbZAMHZs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 02:25:48 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70A80@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 2009-01-13 at 11:14 +0530, Gupta, Ajay Kumar wrote:
> V
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> > Barada
> > Sent: Tuesday, January 13, 2009 1:09 AM
> > To: linux-omap
> > Subject: Missing USB OTG ID interrupt../
> > 
> > On the current PM tree (2.6.28-rc8, revision 2beb9b4b) I have USB OTG
> > working - I see a device plugged in on boot, and it detaches when I pull
> > the cable, but it doesn't appear again when I reinsert the cable.
> 
> Vbus is switched-off when device is detached. Try using the patch at,
> http://marc.info/?l=linux-usb&m=122535802102316&w=2

Thank you, that works fine, great!  Now to test with suspend/resume...


> -ajay
> > 
> > Any ideas on why the device doesn't show up again?
> > 
> > --
> > Peter Barada <peterb@logicpd.com>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Peter Barada <peterb@logicpd.com>
