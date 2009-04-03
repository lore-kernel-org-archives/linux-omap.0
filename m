From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Problems while designing TPS65023 regulator driver
Date: Fri, 3 Apr 2009 13:33:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102A76@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
 <20090226140450.GB8595@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51090 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbZDCIEU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 04:04:20 -0400
In-Reply-To: <20090226140450.GB8595@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mark,

I could not find the commit in linux-OMAP git where the init data is 
passed as a parameter to the regulator_register(). I am dependent 
on this commit for my TPS65023 regulator driver and could not push 
my patch without the commit being in l-o.

Any idea when this would be available in l-o?

Thanks and Regards,
Anuj Aggarwal

Thanks and Regards,
Anuj Aggarwal
 
Platform Support Products
Texas Instruments Inc
Ph: +91-80-2509-9542
TI IP Ph: 509-9542
PSP Products RSS Feed PSP Product Announcements
 

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

