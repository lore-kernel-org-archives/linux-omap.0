From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH]OMAP HDQ driver ioremap changes
Date: Tue, 23 Sep 2008 00:14:00 +0400
Message-ID: <20080922201400.GA25509@2ka.mipt.ru>
References: <43198.192.168.10.89.1222078557.squirrel@dbdmail.itg.ti.com> <20080922130621.GC30680@2ka.mipt.ru> <018001c91cb4$f8088a10$LocalHost@wipultra1303> <20080922132717.GR24627@gandalf.research.nokia.com> <01c201c91cb7$97e06bf0$LocalHost@wipultra1303> <20080922143741.GV24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.80.65]:47753 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbYIVUOs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Sep 2008 16:14:48 -0400
Content-Disposition: inline
In-Reply-To: <20080922143741.GV24627@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Madhusudhan Chikkature <madhu.cr@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Mon, Sep 22, 2008 at 05:37:41PM +0300, Felipe Balbi (felipe.balbi@nokia.com) wrote:
> +/*
> + * Used to control the call to omap_hdq_get and omap_hdq_put.
> + * HDQ Protocol: Write the CMD|REG_address first, followed by
> + * the data wrire or read.
> + */
> +static int init_trans;

This variable is not protected against simultaneous master's access
afaics, isn't it possible to have multiple w1 masters on given board?

-- 
	Evgeniy Polyakov
