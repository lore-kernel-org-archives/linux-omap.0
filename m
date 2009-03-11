From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc7-omap] OMAP1: OMAP_TAG_USB buildfix (OSK)
Date: Wed, 11 Mar 2009 17:28:57 +0200
Message-ID: <20090311152857.GA19730@gandalf>
References: <200903110320.06011.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50212 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZCKP3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:29:08 -0400
Content-Disposition: inline
In-Reply-To: <200903110320.06011.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

On Wed, Mar 11, 2009 at 02:20:05AM -0800, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Build fix:
> 
>   CC      arch/arm/mach-omap1/board-osk.o
>   arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
>   arch/arm/mach-omap1/board-osk.c:512: error: implicit declaration of function 'omap_usb_init'
>   make[1]: *** [arch/arm/mach-omap1/board-osk.o] Error 1
> 
> The error is twofold.  First, USB is on the mainboard, not the Mistral card;
> that's specific to the OSK.  Second, header goofage -- hurts all OMAP1 boards.
> 
> I'm puzzled by the notion tha the "OMAP1: get rid of OMAP_TAG_USB" patch could
> have been compile-tested.

it actually was for all omap1 defconfigs. Weird that these came only now
:-(

-- 
balbi
