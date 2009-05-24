From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: n810 internal mmc boot
Date: Sun, 24 May 2009 12:43:33 +0300
Message-ID: <20090524124333.95293f02.jhnikula@gmail.com>
References: <20090228012717.GB4366@swansys>
	<20090321193355.GG20072@swansys>
	<20090325132610.a859abaf.jarkko.nikula@nokia.com>
	<20090325212631.GG29844@swansys>
	<20090523034415.GP23063@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:39748 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZEXJnf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 May 2009 05:43:35 -0400
Received: by ewy24 with SMTP id 24so2576454ewy.37
        for <linux-omap@vger.kernel.org>; Sun, 24 May 2009 02:43:34 -0700 (PDT)
In-Reply-To: <20090523034415.GP23063@swansys>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green <greenfreedom10@gmail.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

On Fri, 22 May 2009 21:44:15 -0600
green <greenfreedom10@gmail.com> wrote:

> > If I remember correctly:
> > 401b285 DOES work
> > cb4befa does NOT work
> > 
> > That is before/after the v2.6.29-rc1 merge.
> 
> At 401b285, does internal mmc work for you?
> 
Yes it does, nice :-)

This is sales model also so probably the prototype version I used
before in-house was having a broken internal mmc or something. But nice
to know that there is a known commit where this is working.


-- 
Jarkko
