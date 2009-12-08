From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][RFT][PATCH 3/4 v5b] OMAP: McBSP: Introduce caching in
 register write operations
Date: Tue, 8 Dec 2009 09:35:21 +0200
Message-ID: <20091208093521.3905241c.jhnikula@gmail.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
	<200912051447.41777.jkrzyszt@tis.icnet.pl>
	<20091207175534.GZ24013@atomide.com>
	<200912072039.34081.jkrzyszt@tis.icnet.pl>
	<20091207210631.GG24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63520 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZLHHeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 02:34:09 -0500
Received: by bwz27 with SMTP id 27so4160517bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 07 Dec 2009 23:34:15 -0800 (PST)
In-Reply-To: <20091207210631.GG24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Hi, sorry not commenting for few days.

On Mon, 7 Dec 2009 13:06:31 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > For me, the fact that more than one processor type can be configured side by 
> > side it not enough reason here. With your code, if more then one processor 
> > type is configured, twice or tripple as much memory space will be devoted to  
> > two or three cache tables instead of one that can be reused easily, as it is 
> > with mine. Since you cannot run the same instance of the kernel on several 
> > machines simultaneously, only one of those two or three tables is required at 
> > runtime for storing data, so this looks like a waste of expensive memory 
> > unless some kind of runtime optimization that I am not familiar with can
> > happen here. I was even affraid before that one of objections against my idea 
> > of using the cache could be unnecessary waste of memory space.
> 
> Well if you want to optimize it out further, how about just kzalloc it
> during init? Then you have just one copy that gets set the right size
> depending on what you boot.
>  
> > Nevertheless, I'll do it your way. Maybe there are still some other reasons
> > not explicitly expressed yet.
> > 
> > I guess that omap2 part should follow the same pattern, shouldn't it?
> 
How about declaring the reg_cache as a void pointer in struct
omap_mcbsp and allocate the cache and its size in omap_mcbsp_request
according to omap type? Read and write functions would access the
*reg_cache either as 16-bit or 32-bit table depending on omap.

No ifdefs, no unused cache tables in multi-omap binary and cache tables
are allocated only for used ports. I don't think there is need to
preserve cache content over omap_mcbsp_free and new omap_mcbsp_request?


-- 
Jarkko
