From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/3] omap: rx51: board-rx51-peripherals.c updates
Date: Fri, 18 Jun 2010 10:07:44 +0300
Message-ID: <20100618100744.af96df7c.jhnikula@gmail.com>
References: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:65329 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0FRHHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 03:07:24 -0400
Received: by wwb18 with SMTP id 18so539740wwb.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 00:07:22 -0700 (PDT)
In-Reply-To: <1274859017-19509-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

On Wed, 26 May 2010 10:30:14 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Hi
> 
> There are now required sound/soc/ patches in mainline and linux-omap to get
> basic Nokia N900 audio working.
> 
> Patch 1/3 is continuation to earlier set, see
> 
> http://marc.info/?l=linux-omap&m=127306914008392&w=2
> 
> IMO, it should go for 2.6.35 as it's kind of fix for unworking audio due
> codec being in unknown reset state.
> 
Ping? Each of these are for 2.6.36 as the 1/3 doesn't fix any serious
regression.


-- 
Jarkko
