From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Thu, 26 Feb 2009 14:04:50 +0000
Message-ID: <20090226140450.GB8595@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4372 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZBZOEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 09:04:53 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Feb 26, 2009 at 02:41:54PM +0530, Aggarwal, Anuj wrote:

> Since all the five regulators can be controlled using a single i2c
> device, I made a single i2c_board_info structure in my platform
> specific file and put all the regulator_init_data information there:

This is very common - most of the devices that have multiple regulators
also have some other subsystems on them (eg, an RTC or a watchdog) and
use a core driver in drivers/mfd with the individual functions of the
device as child platform drivers so this hasn't come up much.

> Now, the problem is in the tps_65023_probe function. Since it will be
> called only once as there is only one i2c device, I have to register
> all the regulators in that only. But I am not able to communicate the
> same to the regulator core layer. Inside the regulator_register(),
> variable init_data, which equals to dev->platform_data, is always
> pointing to the first array member, which is coming from the evm
> specific file. And it fails to register my second regulator instance,
> set_consumer_device_supply() specifically failing for the second
> iteration. Because of this, the probe function fails.

> How should I handle this scenario? Am I missing something in my implementation?

Use -next or the regulator git at:

	git://git.kernel.org/pub/scm/linux/kernel/git/lrg/voltage-2.6

There the init data is passed as a parameter to regulator_register()
rather than being read from the platform data so the problem goes away.
The relevant commit is 8ec143c801ff0514ce92e69aa2f7bd48e73b9baa.

[Please fix your mail client to wrap at 80 columns - currently you have
no line breaks in paragraphs which makes your mails a bit hard to read
and reply to.]
