From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 8/9] OMAP4: omap4panda: Enable audio support
Date: Thu, 22 Dec 2011 20:24:41 +0200
Message-ID: <4EF375E9.3060201@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com> <1324571902-16918-9-git-send-email-peter.ujfalusi@ti.com> <20111222173216.GJ24444@atomide.com> <4EF3721F.8080908@ti.com> <20111222181518.GM24444@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39873 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096Ab1LVSYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 13:24:40 -0500
Received: by lago2 with SMTP id o2so4605093lag.24
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 10:24:37 -0800 (PST)
In-Reply-To: <20111222181518.GM24444@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/22/2011 08:15 PM, Tony Lindgren wrote:
> OK, sounds good to me. Maybe just make omap4_panda_init_rev() do
> the cpu_is_omap check for now and then you can patch in the dynamic
> detection later on?

Yes, this is exactly what will be done for v3.

>> We can use GPIOs to get the board ID, I'm looking at those for a
>> followup patch.
>> The only issue is that the ID1 GPIO number is different between 4430=
,
>> and 4460 based Panda.
>> We can have similar revision handling as we have for Beagle at the e=
nd.
>=20
> OK great.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
