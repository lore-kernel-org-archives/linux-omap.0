From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/9] HDQ driver fixes
Date: Wed, 24 Sep 2008 14:55:35 +0300
Message-ID: <20080924115535.GP24627@gandalf.research.nokia.com>
References: <42568.192.168.10.89.1222255148.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48904 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIXL4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:56:19 -0400
Content-Disposition: inline
In-Reply-To: <42568.192.168.10.89.1222255148.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Wed, Sep 24, 2008 at 04:49:08PM +0530, ext Madhusudhan Chikkature wrote:
> Hi Tony,
> 
> I am posting a series of nine patches for the HDQ driver. The patch series
> provides cleanup of the driver pointed out by Filipe's diff file, use ioremap
> for HDQ base, replace usage of semaphore with mutex, fixes some commenting
> style and indentation.

one more (and hopefully last) comment, hdq_reg_out should return void:

static inline void hdq_reg_out(struct hdq_data *hdq_data, u32 offset, u8 val)
{
	__raw_writeb(val, hdq_data->hdq_base + offset);
}

If you fix the comments I gave now, I think the patches should be
applied unless someone else has any comments to them. After that, you
could also prepare a patch sending this particular driver to
Evgeniy Polyakov <johnpol@2ka.mipt.ru> Cc:ing
linux-kernel@vger.kernel.org and linux-omap@vger.kernel.org

-- 
balbi
