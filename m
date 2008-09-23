From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 05:24:26 +0300
Message-ID: <20080923022419.GE10156@frodo>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com> <20080922201400.GA25509@2ka.mipt.ru>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59031 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYIWCY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 22:24:58 -0400
Content-Disposition: inline
In-Reply-To: <20080922201400.GA25509@2ka.mipt.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, ext Madhusudhan Chikkature <madhu.cr@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Sep 23, 2008 at 12:14:00AM +0400, Evgeniy Polyakov wrote:
> On Mon, Sep 22, 2008 at 05:37:41PM +0300, Felipe Balbi (felipe.balbi@nokia.com) wrote:
> > +/*
> > + * Used to control the call to omap_hdq_get and omap_hdq_put.
> > + * HDQ Protocol: Write the CMD|REG_address first, followed by
> > + * the data wrire or read.
> > + */
> > +static int init_trans;
> 
> This variable is not protected against simultaneous master's access
> afaics, isn't it possible to have multiple w1 masters on given board?

Don't know much about 1-wire. Someone else should answer that. But I
suppose we should protect it, yeah.

-- 
balbi
