From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [PATCH 1/2] backlight: omap_bl.c is not used anywhere
Date: Mon, 1 Sep 2008 02:47:43 +0200
Message-ID: <fb249edb0808311747h1784ea75of72bf3a6ecf207f5@mail.gmail.com>
References: <1220219817-22651-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:23451 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYIAArq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 20:47:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1593457rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2008 17:47:43 -0700 (PDT)
In-Reply-To: <1220219817-22651-1-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

2008/8/31 Felipe Balbi <me@felipebalbi.com>:
> This file doesn't even have a Makefile entry for building
> it. Looks like it's garbage.

Oh, right. I suppose when merging upstream (where the file was
renamed) Tony properly removed omap_bl.c from Makefile but the file
stayed.
Thanks
