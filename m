From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 11/13 v3] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
Date: Thu, 17 Jun 2010 09:34:41 -0700
Message-ID: <87zkytmxcu.fsf@deeprootsystems.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
	<1276614348-5201-2-git-send-email-charu@ti.com>
	<1276614348-5201-3-git-send-email-charu@ti.com>
	<1276614348-5201-4-git-send-email-charu@ti.com>
	<1276614348-5201-5-git-send-email-charu@ti.com>
	<1276614348-5201-6-git-send-email-charu@ti.com>
	<1276614348-5201-7-git-send-email-charu@ti.com>
	<1276614348-5201-8-git-send-email-charu@ti.com>
	<1276614348-5201-9-git-send-email-charu@ti.com>
	<1276614348-5201-10-git-send-email-charu@ti.com>
	<1276614348-5201-11-git-send-email-charu@ti.com>
	<1276614348-5201-12-git-send-email-charu@ti.com> <4C17B6ED.203@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B62C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B659@dbde02.ent.ti.com>
	<4C189422.7020700@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35548 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020Ab0FQQer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 12:34:47 -0400
Received: by pvg6 with SMTP id 6so53799pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 09:34:45 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B5@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 16 Jun 2010 21\:13\:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>> >>
>> >>>
>> >>> What does 'method' mean in that context? Maybe the name should be revisited?
>> >>
>> >> Agree. 'method' is used throughout OMAP GPIO code. As mentioned above, this
>> field would be removed
>> >> once the whole GPIO code is cleaned up. This patch series doesn't bother to
>> clean up GPIO code as the
>> >> changes would be huge and intended only for HWMOD FW adaptation. Cleaning up
>> GPIO code would come as
>> >> a separate series and we can address this then.
>> >>
>> > Sorry if my comment is not aligned but I thought we are addressing the
>> > gpio clean up as well.
>> >
>> > If we are re-vamping the code so much, is it not the right time to clean up as
>> well ??
>> 
>> I agree with Santosh, you are already cleaning a bunch of things, and in
>> that case you can easily take advantage of HWMOD to remove a good amount
>> of useless code.
>> 
>> We'd better do that right now, instead of waiting a next phase that
>> might never happen...
>
> Since hwmod migration would change mainly the init part of the code,
> I started working on hwmod migration as part of the first
> series. Once we agree upon the final patch set for GPIO hwmod
> migration, I can work on top of the hwmod migration patch series to
> clean up the GPIO code and send a dependent series. This will help
> sending the changes in smaller chunks.
>
> I would add a TODO section in patch description outlining the
> cleanup to be done in the next patch series.

At a minimum, a TODO describing the rest of the cleanups would be
helpful.

> Tony,
> Can you add your feedback?
>
> Please refer http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26065.html for the old context.
>
>> 
>> And BTW, this 'method' is a IP version dependent information and
>> not a Soc specific one. You can potentially use the HW revision
>> field, if it is available for the GPIO.
>
> I agree that it is not SoC specific. But I still feel that it is
> better not to have 'method' as part of dev_attr, considering that,
> after clean-up, this information will no longer be needed.

Considering just this 'method' issue, and not the entire cleanup, I
don't like this extra 'user' field past to omap2_init_gpio() used for
the method.

Can you investigate whether or not this flag is even needed and if we
can determine the method based on the REVISION register?

Kevin
