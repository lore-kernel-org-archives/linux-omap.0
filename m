From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 00/10] split out emac cpdma and mdio for reuse
Date: Tue, 07 Sep 2010 08:22:14 -0700
Message-ID: <87iq2hk28p.fsf@deeprootsystems.com>
References: <1283465008-18606-1-git-send-email-cyril@ti.com>
	<87eida3fl9.fsf@deeprootsystems.com> <4C813C7F.5090602@ti.com>
	<20100906.132802.260095799.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57147 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab0IGPWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 11:22:19 -0400
In-Reply-To: <20100906.132802.260095799.davem@davemloft.net> (David Miller's
	message of "Mon, 06 Sep 2010 13:28:02 -0700 (PDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: cyril@ti.com, netdev@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, nsekhar@ti.com, srk@ti.com, omar.ramirez@ti.com, bparrot@ti.com

David Miller <davem@davemloft.net> writes:

> From: Cyril Chemparathy <cyril@ti.com>
> Date: Fri, 03 Sep 2010 14:20:47 -0400
>
>> Hi Kevin,
>> 
>> [...]
>>>> Although am3517 (omap) board support code has been updated as needed,
>>>> emac does not work on this platform.
>>> 
>>> Just to clarify... did EMAC work on AM3517 before this series?
>> 
>> No.  It didn't work before this series.  To get AM3517 EMAC working, the
>> driver needs another patch to enable the interface clock in addition to
>> the functional clock.
>
> Since this has dependencies on davinci board files and whatnot, why don't
> you merge this via the davinci tree and add my:
>
> Acked-by: David S. Miller <davem@davemloft.net>
>
> Ok?

OK, will do. 

Thanks,

Kevin
