From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Mon, 22 Oct 2012 13:50:23 -0500
Message-ID: <5085956F.8000405@ti.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <50857444.9080308@ti.com> <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com> <alpine.DEB.2.00.1210221835520.13464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab2JVSu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 14:50:27 -0400
In-Reply-To: <alpine.DEB.2.00.1210221835520.13464@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 10/22/2012 01:36 PM, Paul Walmsley wrote:
> On Mon, 22 Oct 2012, Paul Walmsley wrote:
> 
>> On Mon, 22 Oct 2012, Jon Hunter wrote:
>>
>>> and toolchain used for any failures.
>>
>> This would indeed be useful and will try to figure out a good way to add 
>> that information.
> 
> Just realized that some of this appears in the beginning of the bootlogs:
> 
> [    0.000000] Linux version 3.7.0-rc2-00331-g6f0c058 (paul@nozomi) (gcc 
> version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Sat Oct 20 14:04:56 
> MDT 2012
> 
> Not the easiest information to find, but maybe it serves your needs?

Yes, it does. The boot log has all the info we need :-)

Cheers
Jon
