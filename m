From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/20] Create platform_driver for each DSS HW IP
Date: Tue, 31 Aug 2010 08:27:12 -0700
Message-ID: <87d3syu7jj.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
	<1282579089-10487-5-git-send-email-svadivu@ti.com>
	<877hjdszij.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608703114AA766@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58990 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab0HaP1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 11:27:18 -0400
Received: by pzk9 with SMTP id 9so2470165pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 08:27:17 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703114AA766@dbde02.ent.ti.com>
	(Senthilvadivu Guruswamy's message of "Tue, 31 Aug 2010 18:33:09
	+0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>

"Guruswamy, Senthilvadivu" <svadivu@ti.com> writes:

[...]

>> > +/* DSS HW IP initialisation */
>> > +static int omap_dsshw_probe(struct platform_device *pdev)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static int omap_dsshw_remove(struct platform_device *pdev)
>> > +{
>> > +	return 0;
>> > +}
>> 
>> It's not customary to create dummy, empty functions in one patch and
>> then fill them in later.  In this case, you create them here, 
>> move them
>> in PATCH 05/20, then fill them in later.
>> 
>> It would be easier to review if you created the platform_drivers when
>> needed.
>> 
>> Anyways, I'm not crazy about this approach, but Tomi can decide.
>> 
> [Senthil]  As I mentioned in my TODO list, I will try to move all the probe/remove to
> the corresponding driver files as directly in my next version.

Sorry, I missed that in your TODO list.

Thanks,

Kevin
