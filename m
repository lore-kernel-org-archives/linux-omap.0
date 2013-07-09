From: Suman Anna <s-anna@ti.com>
Subject: Re: find real users and drivers of rpmsg
Date: Tue, 9 Jul 2013 16:43:54 -0500
Message-ID: <51DC841A.9070409@ti.com>
References: <CAGsJ_4z3-g_u5qHdoje=MASbRBoRMFjCU4jUfrrCc2836E_umQ@mail.gmail.com> <CAK=WgbYavJUg3WGU9gCF133kEsFF_1ViAT04SDE7Eps8B4h=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35279 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab3GIVte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 17:49:34 -0400
In-Reply-To: <CAK=WgbYavJUg3WGU9gCF133kEsFF_1ViAT04SDE7Eps8B4h=tA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, pandaboard@googlegroups.com

Barry,

> On Mon, Jul 8, 2013 at 10:31 AM, Barry Song <21cnbao@gmail.com> wrote:
>> hi Ohad/all,
>> i am trying to find some real users of rpmsg, here i only get
>> samples/rpmsg/rpmsg_client_sample.c, does it mean other real drivers
>> are out of mainline?
> 
> Yes
> 
>> where could i get them?
> 
> TI maintains them in internal trees, some of which might be public.
> I'm looping in Suman from TI who might be able to refer you to some

You will find couple of rpmsg client drivers in our product kernels.
Following is a kernel used towards our Android product, you can look
in the drivers/rpmsg folder.

http://git.omapzoom.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/p-linux-omap-3.4

> 
>> i am also trying to find source codes running in Cortex-M3 which use
>> rpmsg and hope to find some Linux userspace codes which use rpmsg too.
>> Thanks
>> barry

Some information from the following wiki might also be handy (kinda old,
but still useful) for you to find the equivalent code running on the
Cortex-M3

http://omappedia.org/wiki/Category:RPMsg

regards
Suman

