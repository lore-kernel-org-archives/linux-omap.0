From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH 2/5] staging:ti dspbridge: remove unnecessary check for
 	NULL pointer in cmm.c
Date: Wed, 28 Jul 2010 12:29:39 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060094B73BAD@dlee01.ent.ti.com>
References: <1280328052-31292-1-git-send-email-ernesto@ti.com>
	<1280328052-31292-2-git-send-email-ernesto@ti.com>
	<1280328052-31292-3-git-send-email-ernesto@ti.com>	<4C504719.3020007@ti.com>
	<4C504D66.8090302@ti.com>
	<B852767254C5C94EBB1040EE0EFA060094B73B31@dlee01.ent.ti.com>
 <AANLkTi=3K1NC4nGnuTBdVmTOmmG0JEZrG9vKhOvYgXhf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38810 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312Ab0G1R3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 13:29:49 -0400
In-Reply-To: <AANLkTi=3K1NC4nGnuTBdVmTOmmG0JEZrG9vKhOvYgXhf@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "gregkh@suse.de" <gregkh@suse.de>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Agree! I'll send new version of this patch.

>-----Original Message-----
>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>Sent: Wednesday, July 28, 2010 12:12 PM
>To: Ramos Falcon, Ernesto
>Cc: Menon, Nishanth; gregkh@suse.de; Ramirez Luna, Omar; ohad@wizery.com;
>ameya.palande@nokia.com; felipe.contreras@nokia.com; Guzman Lugo, Fernando;
>linux-kernel@vger.kernel.org; andy.shevchenko@gmail.com; linux-
>omap@vger.kernel.org
>Subject: Re: [PATCH 2/5] staging:ti dspbridge: remove unnecessary check for
>NULL pointer in cmm.c
>
>Hi Ernesto,
>
>On Wed, Jul 28, 2010 at 7:53 PM, Ramos Falcon, Ernesto <ernesto@ti.com>
>wrote:
>>>here is a better approach:
>>>remove cmm_xlator_delete altogether
>
>[...]
>
>> I considered this approach before but in terms of maintainability I
>thought it was easier to locate where translator tables are destroy if we
>keep cmm_xlator_delete function.
>
>That's not maintainability, that's debugging convenience. AFAIU linux
>is all about maintenance, because that provides real, tangible, and
>proven gains. Debugging convenience gains are hypothetical; you don't
>really know how useful it will be to have a separate free function.
>
>And please avoid bottom-posting, instead use interleaved style,
>otherwise people see a comment, and then have to scroll down to see
>the answer.
>http://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>
>--
>Felipe Contreras
