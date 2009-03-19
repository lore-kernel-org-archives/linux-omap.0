From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [APPLIED] [PATCH omap-fixes v2] OMAP2/3: GPIO: do not attempt
	to wake-enable
Date: Thu, 19 Mar 2009 19:27:07 +0200
Message-ID: <20090319172706.GC4639@gandalf>
References: <notify-1237414046@atomide.com> <87skl9mpio.fsf@deeprootsystems.com> <20090319165334.GK29546@atomide.com> <20090319171632.GL29546@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54589 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbZCSR1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 13:27:14 -0400
Content-Disposition: inline
In-Reply-To: <20090319171632.GL29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Thu, Mar 19, 2009 at 10:16:33AM -0700, Tony Lindgren wrote:
> Seems like a bug in pwclient..
> 
> $ pwclient get 10719
> 
> Shows the subject in the patch as:
> 
> Subject: [omap-fixes,
>         v2] OMAP2/3: GPIO: do not attempt to wake-enable GPIO bank IRQ

$ curl http://patchwork.kernel.org/patch/10719/mbox | git am -s

would do the trick :-p

-- 
balbi
