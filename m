From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/20] Build omap_device for each DSS HW IP
Date: Tue, 31 Aug 2010 08:29:35 -0700
Message-ID: <87zkw2ssv4.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
	<874oehuez7.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608703114AA768@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54936 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0HaP3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 11:29:37 -0400
Received: by pzk9 with SMTP id 9so2471437pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Aug 2010 08:29:37 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703114AA768@dbde02.ent.ti.com>
	(Senthilvadivu Guruswamy's message of "Tue, 31 Aug 2010 18:31:15
	+0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>

"Guruswamy, Senthilvadivu" <svadivu@ti.com> writes:

[...]

>> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
>> >
>> > Looks up the HWMOD database for each of the given DSS HW IP
>> > and builds omap_device which inturn does the platform device
>> > register for each of DSS HW IP
>> >
>> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
>> 
>> [...]
>> 
>> > +	for (i = 0; i < 5; i++) {
>> > +		l = snprintf(oh_name[i], MAX_OMAP_DSS_HWMOD_NAME_LEN,
>> > +				 oh_name[i]);
>> > +		WARN(l >= MAX_OMAP_DSS_HWMOD_NAME_LEN,
>> > +			"String buffer overflow in DSS device setup\n");
>> > +
>> > +		oh = omap_hwmod_lookup(oh_name[i]);
>> > +		if (!oh) {
>> > +			pr_err("Could not look up %s\n", oh_name[i]);
>> > +			return ;
>> > +		}
>> > +		strcpy(pdata.name, oh_name[i]);
>> > +		pdata.board_data		=       board_data;
>> > +		pdata.board_data->get_last_off_on_transaction_id = NULL;
>> > +		pdata.device_enable    =       omap_device_enable;
>> > +		pdata.device_idle      =       omap_device_idle;
>> > +		pdata.device_shutdown  =       omap_device_shutdown;
>> 
>> Please use runtime PM API in driver instead of calling these using
>> pdata function pointers.
>
> [Senthil] when I used pm_runtime API, the clocks were not getting enabled.
> Probably the complete support is not yet in this pm branch.
> Once available I would change to pm_runtime and discard the use_count variable too.

Runtime PM is available and working in current pm-core branch
(a.k.a. pm-wip/hwmods-omap4) Several other hwmod conversions are using
that branch to get working runtime PM.

Rather than use the pdata-> methods, please debug why runtime PM isn't
working for your driver.

Thanks,

Kevin

