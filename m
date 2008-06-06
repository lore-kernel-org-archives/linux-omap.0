From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix for the i2c initialiation error on 2430sdp
Date: Fri, 6 Jun 2008 21:07:06 +0300
Message-ID: <20080606180706.GA27972@kedavra.cpe.vivax.com.br>
References: <c656a4d20806060612s55b047b2p783056dfac058093@mail.gmail.com> <d2e4e528efc51e918b953d9b77673ea2@felipebalbi.com> <a0580c510806060757t63d84b82qa889c52f3adcb70c@mail.gmail.com> <FD7816A1-5B40-4554-99B4-1155B53671C1@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43431 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbYFFSHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 14:07:01 -0400
Content-Disposition: inline
In-Reply-To: <FD7816A1-5B40-4554-99B4-1155B53671C1@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: Eduardo Valentin <edubezval@gmail.com>, Felipe Balbi <me@felipebalbi.com>, arun c <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 05:28:44PM +0200, Koen Kooi wrote:
>> If that is the reason, it'd be good to add some comment here to avoid
>> people re-ordering it in the future.
>
> I wonder if this applies to omap3 as well.

Not really. i2c hs bus on omap3 is bus 1. So no problem :-)

That might also be why they changed from bus2 to bus1, maybe. Just
speculating here :-p


-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
