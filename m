From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Wed, 01 Sep 2010 15:51:40 -0700
Message-ID: <87eiddgjr7.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:46481 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab0IAWvp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 18:51:45 -0400
Received: by pxi10 with SMTP id 10so3035086pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 15:51:45 -0700 (PDT)
In-Reply-To: <1282130412-12027-2-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 18 Aug 2010 16:50:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, thomas.petazzoni@free-electrons.com

Thara Gopinath <thara@ti.com> writes:

> This patch introduces a user list of devices associated with each
> voltage domain instance. The user list is implemented using plist
> structure with priority node populated with the voltage values.
> This patch also adds an API which will take in a device and
> requested voltage as parameters, adds the info to the user list
> and returns back the maximum voltage requested by all the user
> devices. This can be used anytime to get the voltage that the
> voltage domain instance can be transitioned into.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Looking closer at this, keeping track of a list of devices and
constraints is what the regulator framework does as well.  

Before we get too far down this path, we need to start working with
Thomas Petazzoni to better understand how we can use the regulator
framework for much of the management levels of the voltage layer.

I'd rather not re-invent some of the management/constraints management
that could be done by the regulator framework.

Basically, I think

  r = regulator_get(dev, voltdm->name)
  regulator_set_voltage(r, volt)

would basially be the equivalent of

  omap_voltage_add_userreq(voldm, dev, &volt);
  omap_scale_voltage(voltdm, volt)

The regulator framework not only provides management of the users and
constraints, but also provides post-change notifiers where things like
dependent voltages could be handled.

Kevin
