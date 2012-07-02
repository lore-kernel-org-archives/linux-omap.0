From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: Current state of AM33xx patches
Date: Mon, 02 Jul 2012 09:04:26 +0100
Message-ID: <4FF1560A.9000805@mimc.co.uk>
References: <4FD5BA4C.9070706@gmail.com>	<4FD5FD9E.5040203@ti.com> <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com> <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com> <4FEDB9BD.7060405@mimc.co.uk> <79CD15C6BA57404B839C016229A409A83EA5FC34@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:50322
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751206Ab2GBIE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:04:28 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5FC34@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Domenico Andreoli <cavokz@gmail.com>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 29/06/12 18:56, Hiremath, Vaibhav wrote:
> On Fri, Jun 29, 2012 at 19:50:45, Mark Jackson wrote:
>>
>> This does appear to work using the ramdisk, but there seems to be no support for booting off MMC.
>>
> 
> This is known thing and clearly mentioned/highlighted above.
> 
> "Use the ramdisk image to boot kernel, since we do not have support for any 
> storage devices in the mainline."

Oops ... missed that, sorry !!

<snip>

>> All in all, the AM335x code does seem to be very fragmented.  Is that just because these are
>> non-trivial changes going in ?
>>
> 
> Not really true.
> 
> The answer is simple, if you are looking for production quality code then 
> certainly you should use something based on PSP release (SDK) and if you 
> want to stay close to Mainline and would like to contribute towards it, you 
> have to understand the process, dependencies, development and discussions 
> happening on the list.

Okay.  Thanks for explaining.

Mark
