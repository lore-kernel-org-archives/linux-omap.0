From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Tue, 09 Feb 2010 10:55:41 +0200
Message-ID: <4B71230D.1000900@compulab.co.il>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com> <20100204142439.GA1139@sirena.org.uk> <6ed0b2681002040652r722e3df2s3f032a9fe0d0c0fe@mail.gmail.com> <20100204162155.GB29982@rakim.wolfsonmicro.main> <f870da181002051245t2f37065duae595fee391e7fd9@mail.gmail.com> <20100208113028.GA15630@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:40124 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab0BII4j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Feb 2010 03:56:39 -0500
In-Reply-To: <20100208113028.GA15630@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

Mark Brown wrote:
> On Fri, Feb 05, 2010 at 10:45:09PM +0200, Mike Rapoport wrote:
>> On Thu, Feb 4, 2010 at 6:21 PM, Mark Brown
> 
>>> The bodge I'm thinking of would do something like log an error and
>>> substitute in a dummy regulator when regulator_get() would have failed
>>> so that the driver sees behaviour equivalent to the stubbed regulator
>>> API if the bodge is active.  A central thing seems much more sensible
>>> here - there's nothing specific to this driver going on here and having
>>> the API behave in a consistent manner seems good.
> 
>> I agree that such approach have more sense than checking for -ENODEV
>> in each and every driver that uses the regulator framework. I just
>> wonder, if there should be some mechanism that  can switch the
>> substitution of the dummy regulators on and off. And if yes, how
>> should the platform code communicate with the regulator core the need
>> for such dummy regulators...
> 
> So, having thought about this a bit more we actually have two different
> use cases here.  One is where you've got a system which has software
> controllable regulators for everything but may not have plumbed in all
> the supplies, the other is for systems where only a very few supplies
> are on software controlled regulators which are just trying to save the
> hassle of hooking up the bulk of the supplies to fixed voltage
> regulators.  These two use cases should probably be handled differently
> - the first one is really expected to have all the supplies hooked up
> and so should warn when using the bodge regulator but the warning isn't
> helpful in the second case.

Sounds right to me.

> We already have some support for boards to set up the API in the form of
> regulator_set_full_constraints() so we could do something similar for
> dummy regulators, or create a new single API to set a bunch of options
> via a struct which is probably less hassle going forward.

Struct sounds more reasonable that just a call to e.g.
regulator_warn_dummy_fixed_regulator :)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
