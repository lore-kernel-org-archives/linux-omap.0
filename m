From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Missing USB OTG ID interrupt../
Date: Tue, 13 Jan 2009 11:14:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECF70A80@dbde02.ent.ti.com>
References: <1231789145.14918.31.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54257 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbZAMFow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 00:44:52 -0500
In-Reply-To: <1231789145.14918.31.camel@blackhole>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

V

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> Barada
> Sent: Tuesday, January 13, 2009 1:09 AM
> To: linux-omap
> Subject: Missing USB OTG ID interrupt../
> 
> On the current PM tree (2.6.28-rc8, revision 2beb9b4b) I have USB OTG
> working - I see a device plugged in on boot, and it detaches when I pull
> the cable, but it doesn't appear again when I reinsert the cable.

Vbus is switched-off when device is detached. Try using the patch at,
http://marc.info/?l=linux-usb&m=122535802102316&w=2

-ajay
> 
> Any ideas on why the device doesn't show up again?
> 
> --
> Peter Barada <peterb@logicpd.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

