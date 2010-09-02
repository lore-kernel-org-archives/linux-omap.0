From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Thu, 02 Sep 2010 11:56:55 -0700
Message-ID: <87occg3rew.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com> <20100902094327.31a96174@surf>
	<4C7F5DB4.70306@ti.com> <87aao082bb.fsf@deeprootsystems.com>
	<4C7FF100.5090204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51553 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab0IBS47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 14:56:59 -0400
Received: by qyk36 with SMTP id 36so2342572qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Sep 2010 11:56:59 -0700 (PDT)
In-Reply-To: <4C7FF100.5090204@ti.com> (Nishanth Menon's message of "Thu, 2
	Sep 2010 13:46:24 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 09/02/2010 12:47 PM, the following:

[...]

>>
>> If you look at the current PM branch (specifically pm-sr), you'll see
>> that with the updated SR layer, there is no SR enable/disable in the
>> idle path because there is no voltage scaling during idle.

[...]

>>
>> That being said, even if this is add later, the idle path can potentialy
>> call the SR API directly if needed for the enable/disable.
>
> not clean if it was directly implemented by regulator framework
>

The idea (so far) is that there will still be a low-level SmartReflex
API, and just a regulator "wrapper."  Thomas P. is experimenting with
extending the regulator framework to be able to call into external
low-level code which does the heavy lifting.  He can probably post an
RFC soon.

Kevin
