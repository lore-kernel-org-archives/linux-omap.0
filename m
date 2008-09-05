From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] backlight: omap_bl.c is not used anywhere
Date: Fri, 5 Sep 2008 09:38:48 -0700
Message-ID: <20080905163848.GD24202@atomide.com>
References: <1220219817-22651-1-git-send-email-me@felipebalbi.com> <fb249edb0808311747h1784ea75of72bf3a6ecf207f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57302 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbYIEQix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:38:53 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0808311747h1784ea75of72bf3a6ecf207f5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* andrzej zaborowski <balrogg@gmail.com> [080831 17:47]:
> 2008/8/31 Felipe Balbi <me@felipebalbi.com>:
> > This file doesn't even have a Makefile entry for building
> > it. Looks like it's garbage.
> 
> Oh, right. I suppose when merging upstream (where the file was
> renamed) Tony properly removed omap_bl.c from Makefile but the file
> stayed.

OK, pushing today.

Tony
