From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 6/10] omap mailbox: remove unnecessary arg for
	omap_mbox_msg_send
Date: Mon, 7 Sep 2009 21:02:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C43EF@dbde02.ent.ti.com>
References: <20090907150243.GB6538@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60075 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbZIGPcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 11:32:02 -0400
In-Reply-To: <20090907150243.GB6538@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Russell,
'arg' is used later in Patch 10, as part of the tasklet implementation, for writing messages to the mailbox. Should I be removing it in patch 6 and introduce it only for the tasklet implementation?

Thank you and regards
Subbu 

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk] 
> Sent: Monday, September 07, 2009 8:33 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> Hiroshi.DOYU@nokia.com; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 6/10] omap mailbox: remove unnecessary 
> arg for omap_mbox_msg_send
> 
> On Fri, Sep 04, 2009 at 05:18:04PM +0530, C.A, Subramaniam wrote:
> > @@ -114,7 +114,6 @@ int omap_mbox_msg_send(struct omap_mbox 
> *mbox, mbox_msg_t msg, void* arg)
> >  	}
> >  
> >  	tx_data->msg = msg;
> > -	tx_data->arg = arg;
> 
> What about also removing 'arg' from struct omap_msg_tx_data ?
> 
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
> 
> 