From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Fri, 7 Aug 2009 23:17:12 +0300
Message-ID: <20090807201712.GB9780@nokia.com>
References: <1249589441.10885.75.camel@blitz>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
 <1249665817.11736.21.camel@blitz>
 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
 <1249672953.11736.76.camel@blitz>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62025 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933608AbZHGUQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 16:16:02 -0400
Content-Disposition: inline
In-Reply-To: <1249672953.11736.76.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter Barada <peterb@logicpd.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Aug 07, 2009 at 09:22:33PM +0200, ext Peter Barada wrote:
> Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
> thumbdrive plugged in, and then modprobe the driver, it finds the
> thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
> multiple times, and each time it is enumerated.
> 
> If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
> musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
> enumerated.
> 
> Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
> boot for it to enumerate the thumbdrive?

which board are you using ?

-- 
balbi
