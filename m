From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 15:16:36 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436A4A611@dbde02.ent.ti.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
 <4A97A1FF.5050501@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZH1JrM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:47:12 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

> This part is being done at musb_host_rx() 

musb_host_tx() ofcourse.

> doing next packet programming
> within same urb and *not* starting next urb. Thus musb_start_urb() doesn't
> come into this path. So it wouldn't start the DMAs.
> 
> In case of PIO, it does load the FIFO and sets the TXPKTREADY.
> 
> -Ajay
> 
> >
> > WBR, Sergei
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

