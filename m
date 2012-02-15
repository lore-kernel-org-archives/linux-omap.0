From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 15 Feb 2012 16:32:29 -0600
Message-ID: <CAJ6Av5OaraduTOO5qDShxaUoKCC9qdFJiH4M2ccexjD3hTmtKg@mail.gmail.com>
References: <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<20120210180015.GF4141@mwanda>
	<CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
	<20120210203537.GG4141@mwanda>
	<CAMP44s2OEvn7RVpwJ2zkdkxrzwrbD3+PFQbzYiOG-hvnrc4UhA@mail.gmail.com>
	<CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
	<CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
	<CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
	<CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
	<CAB-zwWjkCqehNAKp=gFt6Zq=XR+Mscz67oGnfY2sPjgvgpvNFQ@mail.gmail.com>
	<20120215094357.GA24331@lit.local.igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65062 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631Ab2BOWc3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 17:32:29 -0500
Received: by obcva7 with SMTP id va7so2139845obc.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 14:32:29 -0800 (PST)
In-Reply-To: <20120215094357.GA24331@lit.local.igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>

2012/2/15 V=EDctor M. J=E1quez L. <vjaquez@igalia.com>:
> On Tue, Feb 14, 2012 at 08:56:11PM -0600, Ramirez Luna, Omar wrote:
>> On Tue, Feb 14, 2012 at 10:23 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> >> When that case is applicable, we should first modify the loader c=
ode
>> >> or prepare the baseimages to be common so we can get rid of speci=
fic
>> >> loaders and just dump them into memory.
>> >
>> > I'd say the less workarounds, the better.
>>
>> If there are ever more base images compatible with the dsp, I would
>> say that unifying them into a common format to be dumped in memory
>> isn't a workaround, and in that process we can get rid of the custom
>> loader code.
>
> Yes! please! and use Ohad's rproc thingy.

Yes it would be nice, in theory we could replace some parts with
remoteproc maybe not the loader yet, not sure how much rpmsg will fit.

> What would be the steps to unify that common format? I guess we will =
depend on
> TI for that... Do we?

I don't know the stance of TI on this.

But basically we have a loader in kernel space that prepares the
baseimage to be dumped in memory, that can be done in user space or
better to distribute a baseimage that just needs to be dumped in
memory, however there might be some constraints that need to be solved
like the tight coupling between the driver and the loader, the current
format of the base image, the size and how it expands to fit in the
6MB of shm, and so on, not to mention the ability to load dynamic
code.

I guess it would be better to dive in the code and see.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
