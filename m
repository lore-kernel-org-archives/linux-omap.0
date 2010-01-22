From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH v2 1/6] omap3: pm: re-program the sleep state of TRITON
 resources by modifying the REMAP register
Date: Fri, 22 Jan 2010 10:41:37 -0600
Message-ID: <4B59D541.7010902@ti.com>
References: <1263922501-13701-1-git-send-email-x0080970@ti.com>	<4B572121.50402@compulab.co.il>	<020501ca9a60$71a2e800$LocalHost@wipultra1385>	<4B58E397.4080506@ti.com> <87ljfrdmnr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54251 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab0AVQmG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 11:42:06 -0500
In-Reply-To: <87ljfrdmnr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Manuel, Lesly Arackal" <x0080970@ti.com>, Mike Rapoport <mike@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Derrick, David" <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Kevin Hilman wrote:
> Mike Turquette <mturquette@ti.com> writes:
> 
>> Lesly AM wrote:
> 
> [...]
> 
>>> From: "Mike Rapoport" <mike@compulab.co.il>
> 
> [...]
> 
>>>> Is it necessary to initialize the remap sleep twice?
>>>>
>>> No.
>>> Sorry..  I didn't notice that Amit has already pushed this.
>> The existing remap programming does have a bug in it.  Lesly, try
>> adding the following to this patch:
> 
> And this fix should be sent as a separate patch to Samuel and queued
> as a fix for 2.6.33.

Will test and send patch soon.

Mike

> Kevin

