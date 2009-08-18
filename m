From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [RFC][PATCH 1/2] OMAP4: sDMA drvier: adding OMAP kConfig option
	CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
Date: Tue, 18 Aug 2009 09:33:00 +0530
Message-ID: <618f0c910908172103g7b2d7968wce454b65fbc3a84d@mail.gmail.com>
References: <0680EC522D0CC943BC586913CF3768C003790C62AD@dbde02.ent.ti.com>
	 <87k518ppoy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:21042 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbZHREC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 00:02:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so3204911and.1
        for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 21:03:00 -0700 (PDT)
In-Reply-To: <87k518ppoy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Kevin,
On Thu, Aug 13, 2009 at 5:09 AM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> "S, Venkatraman" <svenkatr@ti.com> writes:
>
>> The hardware feature is available on OMAP4430 and also expected to b=
e
>> in OMAP3630. Hence the feature flag will control the inclusion of th=
e additional functions.
>>
>> Addition of omap kconfig option CONFIG_OMAP_DMA_DESCRIPTOR_LOAD.
>
> Short version: (a.k.a caveman version)
>
> - Compile-time option: bad.
> - Run-time option: good.
>
> Long version:
>
> Without looking at the docs, I would hope that the some revision reg
> or similar would report whether this feature is available or not. =A0=
The
> user configuring the kernel should not have to know whether his SoC
> has this feature or not.
>
> Kevin
> --
Thanks for your comments.
Yes, the DMA_CAPS_0 register contains flags for linked list capability
and it can be checked.
  Obviously, I intended this (compile time flag) for code space
saving for all older platforms. Not only in this file, but all client
drivers those that would eventually start using this capability.
 I am preparing a patch with the runtime check (+ other changes you'd
suggested), but I am curious to know what's the general threshold at
which compile time flag (and it's associated code savings) is
considered a valid trade off?

Thanks and regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
