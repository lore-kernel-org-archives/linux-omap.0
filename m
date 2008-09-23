From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 10:52:22 +0400
Message-ID: <20080923065221.GA25231@2ka.mipt.ru>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com> <20080922201400.GA25509@2ka.mipt.ru> <20080923022419.GE10156@frodo> <00da01c91d38$38421a00$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.80.65]:33001 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbYIWGxU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Sep 2008 02:53:20 -0400
Content-Disposition: inline
In-Reply-To: <00da01c91d38$38421a00$LocalHost@wipultra1303>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Sep 23, 2008 at 10:22:41AM +0530, Madhusudhan Chikkature (madhu.cr@ti.com) wrote:
> >> > +/*
> >> > + * Used to control the call to omap_hdq_get and omap_hdq_put.
> >> > + * HDQ Protocol: Write the CMD|REG_address first, followed by
> >> > + * the data wrire or read.
> >> > + */
> >> > +static int init_trans;
> >> 
> >> This variable is not protected against simultaneous master's access
> >> afaics, isn't it possible to have multiple w1 masters on given board?
> > 
> > Don't know much about 1-wire. Someone else should answer that. But I
> > suppose we should protect it, yeah.
> 
> We can not test that scenario on our board. But I guess we should protect it as 1-Wire protocol supports multiple access.

Doesn't this variable tell how to operate on given w1 master device? In
this case having two or more of them will force all masters to operate
in given mode, which likely not what you want. I think it should live in
per-master private data, and since this variable access is guarded by
master's lock, it should be ok.

-- 
	Evgeniy Polyakov
