From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: rmgr/node.c code cleanup
Date: Mon, 13 Dec 2010 22:01:22 -0600
Message-ID: <AANLkTimWbOmcqYa5ubvmvU9uj4s=v7QhaeHtmhzBp9ss@mail.gmail.com>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	<1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
	<1291933352.23672.52.camel@atlantis.mindbit.ro>
	<AANLkTikLoNf-NDb6kCQnVHB95zrTKi2f9CU6m_u0A+KB@mail.gmail.com>
	<1292163629.2375.5.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40726 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753591Ab0LNEBX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 23:01:23 -0500
Received: by mail-gy0-f176.google.com with SMTP id 1so116418gyf.35
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 20:01:23 -0800 (PST)
In-Reply-To: <1292163629.2375.5.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Sun, Dec 12, 2010 at 8:20 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
>> > Are the other modes (rdma, zerocopy) not supported at all?
>>
>> No, those modes are not supported... the only one working for dsp
>> streams is proc-copy.
>>
>
> Is there any plan to make them work? If not, maybe the code that handles
> them should be removed...

I don't think there is any plan to support these modes, they have been
disabled long time ago, even before the first versions of tidspbridge,
I agree we should start thinking about removing them.

Regards,

Omar
