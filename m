From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: PATCH] OMAP3: add mailbox initialization for 3630
Date: Thu, 25 Mar 2010 18:44:38 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CADC341A@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CADC33F9@dlee06.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4AB211C7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab0CYXon convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 19:44:43 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4AB211C7@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>



>-----Original Message-----
>From: Kanigeri, Hari
>Sent: Thursday, March 25, 2010 4:56 PM
>To: Guzman Lugo, Fernando; linux-omap@vger.kernel.org
>Cc: Doyu Hiroshi (Nokia-D/Helsinki); Palande Ameya (Nokia-D/Helsinki);
>Felipe Contreras
>Subject: RE: PATCH] OMAP3: add mailbox initialization for 3630
>
>Fernando,
>
>> +	if (cpu_is_omap2420() || cpu_is_omap3430() ||
>> +				cpu_is_omap3630() || cpu_is_omap44xx())
>
>looks like this check is applied to all OMAPS. Can we just remove this
>check ?

There is more defines for more versions like:

cpu_is_omap2422
cpu_is_omap3503
... etc,

But I suppose that the mailbox is valid for all of them 24XX, 34XX, 36XX, 44XX. But then why it was only checking for cpu_is_omap2420 or cpu_is_omap3430 or cpu_is_omap44xx?

Maybe someone knows the reason. Otherwise I agree with you.

Regards,
Fernando.



>
>Thank you,
>Best regards,
>Hari
