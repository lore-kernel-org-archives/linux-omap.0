From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Fri, 03 Sep 2010 11:27:50 -0700
Message-ID: <87r5haznq1.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59413 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab0ICS1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 14:27:54 -0400
Received: by qyk36 with SMTP id 36so270961qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 11:27:53 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 3 Sep 2010 12:39:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

> I agree probably regulator framework would be 
> the best place for this but then IMO regulator framework needs a lot of
> changes to support the kind of use-counting we need in the voltage layer.
> To start with regulator_get  keeps the use counting only for enabling or
> disabling a regulator. It does not have a mechanism of adding the requested
> voltage to a list and picking out the highest among the added values.
> regulator_set_voltage could be used to route the call to omap_scale_voltage
> but then it is just a wrapper.

Hi Thara,

Based on feedback from regulator folks (and also remembering that we
agreed to use the regulator framework as a later phase) let's keep your
current approach as an interim solution, but knowing that we will
eventually switch to use the regulator framework for handling multiple
requests.

In the background Thomas and I will continue to research the changes
needed in the regulator framework.

Thanks,

Kevin
