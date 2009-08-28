From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [RESEND][PATCH 0/2] McSPI Slave and DMA , FIFO support
Date: Fri, 28 Aug 2009 10:32:36 -0700
Message-ID: <200908281032.36878.david-b@pacbell.net>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com> <200908272242.20636.david-b@pacbell.net> <060601ca27d7$d2a87df0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n20.bullet.mail.mud.yahoo.com ([68.142.206.147]:40868 "HELO
	n20.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751054AbZH1Rcg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 13:32:36 -0400
In-Reply-To: <060601ca27d7$d2a87df0$LocalHost@wipultra793>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Friday 28 August 2009, Hemanth V wrote:
> So would it be possible to merge the slave support also for
> now, and could be modified to support the new slave interface
> as and when available.

Not really.  You still haven't split the non-slave stuff into
a patch, note ..

