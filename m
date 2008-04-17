From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 13:17:19 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804171316560.8530@utopia.booyaka.com>
References: <20080416205119.GF17055@atomide.com> <200804171140.59906.david-b@pacbell.net> <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com> <200804171154.02983.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41249 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbYDQTRV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 15:17:21 -0400
In-Reply-To: <200804171154.02983.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hello David,

On Thu, 17 Apr 2008, David Brownell wrote:

> struct dentry *debugfs_create_file(const char *name, mode_t mode,
>                                    struct dentry *parent, void *data,
>                                    const struct file_operations *fops);
> 
> ... provide a file_operations vector supporting writes.  Or building
> more complex values with seq_file, etc.

thanks, missed that.  That would indeed work.


- Paul
