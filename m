From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 3/3] omap: add hwspinlock device
Date: Wed, 20 Oct 2010 14:20:14 +1300
Message-ID: <4CBE43CE.404@bluewatersys.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>	<1287387875-14168-4-git-send-email-ohad@wizery.com>	<87r5fmxghm.fsf@deeprootsystems.com>	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com> <87bp6pviwf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.bluewatersys.com ([202.124.120.130]:22276 "EHLO
	hayes.bluewaternz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754117Ab0JTBTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 21:19:35 -0400
In-Reply-To: <87bp6pviwf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Simon Que <sque@ti.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/20/2010 12:53 PM, Kevin Hilman wrote:
> Ohad Ben-Cohen <ohad@wizery.com> writes:
> 
>> On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>>> +postcore_initcall(hwspinlocks_init);
>>>
>>> Any reason this needs to be a postcore_initcall?  Are there users of
>>> hwspinlocks this early in boot?
>>
>> i2c-omap, which is subsys_initcall (the I2C bus is shared between the
>> A9 and the M3 on some OMAP4 boards).
> 
> Rather than moving towards having more drivers have to be built in (and
> depend on their probe order) we need to be moving towards building all
> these drivers as modules, including omap-i2c.

The issue of probe order still needs to be resolved for those of us who
do want all the drivers built into the kernel. Everything comes out in
the wash already if everything is built as modules by installing the
modules in the correct order right?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
