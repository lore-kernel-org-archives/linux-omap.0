From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 5/5] ARM: OMAP: remove unnecessary locking in clk_get_rate()
Date: Wed, 04 Jun 2008 09:35:26 -0700
Message-ID: <4846C44E.9090102@mvista.com>
References: <1211323550-5318-1-git-send-email-khilman@mvista.com> <1211323550-5318-2-git-send-email-khilman@mvista.com> <1211323550-5318-3-git-send-email-khilman@mvista.com> <1211323550-5318-4-git-send-email-khilman@mvista.com> <1211323550-5318-5-git-send-email-khilman@mvista.com> <1211323550-5318-6-git-send-email-khilman@mvista.com> <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:55286 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYFDQf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2008 12:35:28 -0400
In-Reply-To: <alpine.DEB.1.00.0806040058450.1170@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley wrote:
> 
> Hi Kevin,
> 
> On Tue, 20 May 2008, Kevin Hilman wrote:
> 
>  > The locking in the get_rate() hook is unnecessary, and causes problems
>  > when used with the -rt patch, since it may be called recursively.
>  >
>  > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> BTW, looks like we could probably get rid of some of the other spinlocking
> in plat-omap/clock.c also -- clk_get_usecount() ?

I agree, most of the locking in there seems unnecessary, but this was 
the only one that could be removed without looking closer at at all the 
platform specific clock code.

Basically, I think there minimal (maybe no) locking in the generic 
layer, and the locking should be done if necessary in the platform 
specific parts.

Kevin
