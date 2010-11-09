From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime api's
Date: Tue, 09 Nov 2010 09:41:26 -0800
Message-ID: <87tyjqqtrt.fsf@deeprootsystems.com>
References: <1285078036-12789-2-git-send-email-rnayak@ti.com>
	<1285078036-12789-3-git-send-email-rnayak@ti.com>
	<1285078036-12789-4-git-send-email-rnayak@ti.com>
	<1285078036-12789-5-git-send-email-rnayak@ti.com>
	<1285078036-12789-6-git-send-email-rnayak@ti.com>
	<20100927223645.GJ21564@trinity.fluff.org>
	<0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
	<20100928233334.GS21564@trinity.fluff.org>
	<87vd5d9a68.fsf@deeprootsystems.com>
	<20101027073501.GK21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33916 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab0KIRla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 12:41:30 -0500
In-Reply-To: <20101027073501.GK21564@trinity.fluff.org> (Ben Dooks's message
	of "Wed, 27 Oct 2010 08:35:01 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ben Dooks <ben-i2c@fluff.org> writes:

> On Thu, Oct 07, 2010 at 10:37:03AM -0700, Kevin Hilman wrote:
>> Ben Dooks <ben-i2c@fluff.org> writes:
>> 
>> [...]
>> 
>> > As such, I should really go and read up all about this new runtime-pm
>> > and hwmod stuff before further commentign on the changes.
>> 
>> ping
>> 
>> >From the drivers perspective, you don't neet to know anything about
>> omap_hwmod.  You can think of this change as simply using the runtime PM
>> API instead of the clock API for enabling and idling the device.
>> 
>> With your ack (on this patch only) we'd like to merge this along with
>> the rest of the series for 2.6.37.
>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
>
> please post via your tree.

Thanks Ben,

Will queue up for 2.6.38.

Kevin
