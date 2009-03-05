From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Problems while designing TPS65023 regulator driver
Date: Thu, 5 Mar 2009 17:33:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FADBF6CF@dbde02.ent.ti.com>
References: <20090226140450.GB8595@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbZCEMES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 07:04:18 -0500
In-Reply-To: <20090226140450.GB8595@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mark,

Thanks for the patch, it worked fine for me.

I am facing one more problem now. I am setting boot_on flag in the constraints structure for all my regulators as they are enabled when the system is powered on.
But still when I call regulator_disable() after doing a _get() on it, the call fails saying " unbalanced disables for supply". Then I checked the same repository again and found commit 38db9f31d6dc6147b87692b3b5a8a32de1a6cbe6 (regulator: Allow boot_on regulators to be disabled by clients). But still, it is not allowing me to disable the regulator as soon as I do a get on it.


Later, I found out that in set_machine_constraints(),ops->enable() is being called if the boot_on flag is set. What is the purpose of doing this? Since the regulator is already enabled, why we are calling the ops->enable() to do the same again? In my opinion, regulator_enable() should have been called to let the framework increase its usage count so that the user can disable the same as and when required.


Thanks and Regards,
Anuj Aggarwal
 

> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk]
> Sent: Thursday, February 26, 2009 7:35 PM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Problems while designing TPS65023 regulator driver
> 
> On Thu, Feb 26, 2009 at 02:41:54PM +0530, Aggarwal, Anuj wrote:
> 
> > Since all the five regulators can be controlled using a single i2c
> > device, I made a single i2c_board_info structure in my platform
> > specific file and put all the regulator_init_data information there:
> 
> This is very common - most of the devices that have multiple regulators
> also have some other subsystems on them (eg, an RTC or a watchdog) and
> use a core driver in drivers/mfd with the individual functions of the
> device as child platform drivers so this hasn't come up much.
> 
> > Now, the problem is in the tps_65023_probe function. Since it will be
> > called only once as there is only one i2c device, I have to register
> > all the regulators in that only. But I am not able to communicate the
> > same to the regulator core layer. Inside the regulator_register(),
> > variable init_data, which equals to dev->platform_data, is always
> > pointing to the first array member, which is coming from the evm
> > specific file. And it fails to register my second regulator instance,
> > set_consumer_device_supply() specifically failing for the second
> > iteration. Because of this, the probe function fails.
> 
> > How should I handle this scenario? Am I missing something in my implementation?
> 
> Use -next or the regulator git at:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/lrg/voltage-2.6
> 
> There the init data is passed as a parameter to regulator_register()
> rather than being read from the platform data so the problem goes away.
> The relevant commit is 8ec143c801ff0514ce92e69aa2f7bd48e73b9baa.
> 
> [Please fix your mail client to wrap at 80 columns - currently you have
> no line breaks in paragraphs which makes your mails a bit hard to read
> and reply to.]

