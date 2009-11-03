From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Restart after 4 min of operation?
Date: Tue, 03 Nov 2009 11:41:59 -0700
Message-ID: <4AF07977.50007@mlbassoc.com>
References: <4AEFA4EE.40308@billgatliff.com> <4AF01901.2050100@mlbassoc.com>,<4AF06CBA.3040609@billgatliff.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C8629B@dbde02.ent.ti.com> <4AF07876.4050602@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:47583 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZKCSlz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 13:41:55 -0500
In-Reply-To: <4AF07876.4050602@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11/03/2009 11:37 AM, Bill Gatliff wrote:
> Gadiyar, Anand wrote:
>> I suspect a watchdog timer of some kind, but I haven't got a clue which one.
>>
>
> Turns out I had disabled watchdog timer support in my kernel.
> Re-enabling it seems to have addressed the problem--- the system has run
> for more than 5 minutes now.  :)
>
> Apparently, the default for the OMAP watchdog timer is "armed" at
> reset?  Interesting.

I'm pretty sure this is set up in U-Boot.

If I were you, I'd ask the customer for the U-Boot modifications
so you can check what they've done.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
