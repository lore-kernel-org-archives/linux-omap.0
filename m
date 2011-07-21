From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2] OMAP4: OPP: add OMAP4460 definitions
Date: Wed, 20 Jul 2011 17:04:35 -0700
Message-ID: <87k4bcfqi4.fsf@ti.com>
References: <1309758042-17208-1-git-send-email-vishwanath.bs@ti.com>
	<f1dff603251827d0e02bc74ebc871388@mail.gmail.com>
	<87wrfejo63.fsf@ti.com>
	<cf569df6d3275b4143c3b350ff5e2bf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55377 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906Ab1GUAEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jul 2011 20:04:39 -0400
Received: by iwi5 with SMTP id 5so641766iwi.7
        for <linux-omap@vger.kernel.org>; Wed, 20 Jul 2011 17:04:38 -0700 (PDT)
In-Reply-To: <cf569df6d3275b4143c3b350ff5e2bf5@mail.gmail.com> (Vishwanath
	Sripathy's message of "Wed, 20 Jul 2011 23:00:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Nishanth Menon <nm@ti.com>

Vishwa,

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

>> A quick glance now suggests it has a few minor problems.
>>
>> - patch was not Cc's to linux-arm-kernel
>> - uses 44XX naming which is not used in l-o master
> Sorry I did not get this point. What do you mean by 44XX naming?
> I applied this patch against lo master and it seems to apply and compile
> perfectly fine.

You're right.  Sorry, my fault.

I thought I saw some CHIP_IS stuff in this patch using the 44XX naming
that Tony did not merge for 3.1, but I was mistaken.  It's only used in
some register offset defines, which is fine.

Kevin
