From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Fri, 6 Mar 2009 13:34:30 +0000
Message-ID: <20090306133428.GA4327@sirena.org.uk>
References: <20090226140450.GB8595@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FADBF6CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1176 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbZCFNek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 08:34:40 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FADBF6CF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 05, 2009 at 05:33:55PM +0530, Aggarwal, Anuj wrote:

[Please fix your mail client to wrap lines at ~80 columns - not doing so
makes your mails much harder to read and reply to.]

> But still when I call regulator_disable() after doing a _get() on it,
> the call fails saying " unbalanced disables for supply". Then I checked
> the same repository again and found commit
> 38db9f31d6dc6147b87692b3b5a8a32de1a6cbe6 (regulator: Allow boot_on
> regulators to be disabled by clients). But still, it is not allowing me
> to disable the regulator as soon as I do a get on it. 

You'll need to do an enable followed by a disable for the benefit of the
reference counting that is done for the consumer usage.  What is the
consumer driver here?

> Later, I found out that in set_machine_constraints(),ops->enable() is
> being called if the boot_on flag is set. What is the purpose of doing
> this? Since the regulator is already enabled, why we are calling the
> ops->enable() to do the same again? In my opinion, regulator_enable()

This ensures that the regulator is actually turned on.  Previously
boot_on was equivalent to always_on and there was no way for a machine
driver to turn a regulator on at startup so the semantics of boot_on
were changed slightly to be usable to switch a regulator on at boot.

We could check to see if the regulator is already enabled but it didn't
really seem worth it - if it's a problem a check could be added to query
to see if the regulator is enabled before applying the boot/always on
constraints.

> should have been called to let the framework increase its usage count so
> that the user can disable the same as and when required.

This wouldn't do what you want - the regulator reference counts are two
level, they're counted in the consumer and then the regulator counts the
number of consumers which enable it.  If the core uses regulator_enable
that means it has a consumer allocated for the regulator and that
consumer will end up forcing the regulator to be always on (this was
essentially what the previous boot_on implementation ended up doing).

Consumers need to enable regulators they want to use even if they are
already enabled since otherwise the core may decide to disable the
regulator due to the action of some other consumer which is sharing the
supply.
