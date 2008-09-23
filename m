From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 10:22:41 +0530
Message-ID: <00da01c91d38$38421a00$LocalHost@wipultra1303>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com> <20080922201400.GA25509@2ka.mipt.ru> <20080923022419.GE10156@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42981 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbYIWExd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 00:53:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Felipe Balbi" <me@felipebalbi.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Cc: "Felipe Balbi" <felipe.balbi@nokia.com>; "ext Madhusudhan Chikkature" <madhu.cr@ti.com>; <tony@atomide.com>; <linux-omap@vger.kernel.org>
Sent: Tuesday, September 23, 2008 7:54 AM
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes


> On Tue, Sep 23, 2008 at 12:14:00AM +0400, Evgeniy Polyakov wrote:
>> On Mon, Sep 22, 2008 at 05:37:41PM +0300, Felipe Balbi (felipe.balbi@nokia.com) wrote:
>> > +/*
>> > + * Used to control the call to omap_hdq_get and omap_hdq_put.
>> > + * HDQ Protocol: Write the CMD|REG_address first, followed by
>> > + * the data wrire or read.
>> > + */
>> > +static int init_trans;
>> 
>> This variable is not protected against simultaneous master's access
>> afaics, isn't it possible to have multiple w1 masters on given board?
> 
> Don't know much about 1-wire. Someone else should answer that. But I
> suppose we should protect it, yeah.

We can not test that scenario on our board. But I guess we should protect it as 1-Wire protocol supports multiple access.

Regards,
Madhu
> 
> -- 
> balbi
> 
>
