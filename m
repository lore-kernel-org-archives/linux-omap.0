From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Thu, 02 Sep 2010 10:47:52 -0700
Message-ID: <87aao082bb.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf>
	<4C7F5DB4.70306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33521 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab0IBRsG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 13:48:06 -0400
Received: by pvg2 with SMTP id 2so252658pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Sep 2010 10:48:05 -0700 (PDT)
In-Reply-To: <4C7F5DB4.70306@ti.com> (Nishanth Menon's message of "Thu, 2 Sep
	2010 03:17:56 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Thomas Petazzoni had written, on 09/02/2010 02:43 AM, the following:
>> Hello,
>>
>> On Wed, 01 Sep 2010 15:51:40 -0700
>> Kevin Hilman <khilman@deeprootsystems.com> wrote:
>>
>>> Looking closer at this, keeping track of a list of devices and
>>> constraints is what the regulator framework does as well.  
>>>
>>> Before we get too far down this path, we need to start working with
>>> Thomas Petazzoni to better understand how we can use the regulator
>>> framework for much of the management levels of the voltage layer.
>>
>> Yes, as discussed on IRC with Kevin, I think that some of this voltage
>> layer mechanisms would benefit from using the existing kernel regulator
>> framework.
>>
>> The regulator framework already keeps tracks of consumers (in your
>> patch set called "vdd users"), and for each consumer, keeps track of
>> the requested voltage. The maximum requested voltage is then applied to
>> the regulator. It seems to fit quite well some of the mechanisms you're
>> introducing in this patch set.
>
> Just brainstorming -> if we use the regulator framework - there are
> potential benefits - agreed. BUT, consider the cpuidle path ->
> currently we disable SR while hitting off/ret for class3, this is done
> in irq locked context while the regulator framework uses locks by
> itself - we would probably have to evolve an entirely different
> mechanism to handle this.
>
> SR by itself can easily be represented I believe and my thoughts  when
> i initialy looked at that option had been:
> a) latency overheads
> b) flexibility we achieve vs complexity in s/w implementation
> c) lock handling - esp impact on omap_sram_idle paths..

If you look at the current PM branch (specifically pm-sr), you'll see
that with the updated SR layer, there is no SR enable/disable in the
idle path because there is no voltage scaling during idle.

That being said, even if this is add later, the idle path can potentialy
call the SR API directly if needed for the enable/disable.

The concern Thomas and I are raising is that we don't want to re-invent
regulator framework functionality in the OMAP voltage layer.  Rather, we
should keep the OMAP voltage layer as the part that touches the HW, but
use the regulator framework for the higher-level management of users and
constraints.

Performance issues can be addressed as we hit them, but at this level of
the design, I want to make sure the frameworks make sense.

Kevin

