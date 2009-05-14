From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code
	cleanup
Date: Thu, 14 May 2009 11:00:58 -0700
Message-ID: <20090514180058.GN5593@atomide.com>
References: <49E89649.9050103@yandex.ru> <1239981547-30944-1-git-send-email-ameya.palande@nokia.com> <49E8A50D.2010602@yandex.ru> <27F9C60D11D683428E133F85D2BB4A530404A089E0@dlee03.ent.ti.com> <94a0d4530904250442h5888d61fie0f2ec60f6384ab7@mail.gmail.com> <BA44A5A6-F51F-4ED0-88E4-9AD8BB6785A2@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56403 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZENSBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 14:01:00 -0400
Content-Disposition: inline
In-Reply-To: <BA44A5A6-F51F-4ED0-88E4-9AD8BB6785A2@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap List <linux-omap@vger.kernel.org>

* Koen Kooi <k.kooi@student.utwente.nl> [090425 07:48]:
> Op 25 apr 2009, om 13:42 heeft Felipe Contreras het volgende geschreven:
>
>> While there has been good progress in the bridgedriver, it is still
>> *very* far away from meeting mainline standards and this makes many
>> people uneasy, including me.
>
>
> Is it "good enough" to go into Greg KHs staging tree?

I'd rather keep any code that does non-standard tinkering
of omap registers out of the mainline tree until the basics are
fixed.

Regards,

Tony
