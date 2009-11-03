From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Restart after 4 min of operation?
Date: Tue, 03 Nov 2009 04:50:25 -0700
Message-ID: <4AF01901.2050100@mlbassoc.com>
References: <4AEFA4EE.40308@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:38848 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbZKCLuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 06:50:21 -0500
In-Reply-To: <4AEFA4EE.40308@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-omap@vger.kernel.org

On 11/02/2009 08:35 PM, Bill Gatliff wrote:
> Guys:
>
>
> Can someone give me any ideas as to why my Beagleboard-like platform
> would spontaneously restart after precisely four minutes of operation?
> No OOPS, no nothing.  This is with 2.6.32-rc5.
>

BeagleBoard like?  More details are probably required for much help.

How do you power it?  My BeagleBoard is powered via the OTG.  I've
seen it reset if I hang too much on the USB host port (exceed the
meager power budget)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
