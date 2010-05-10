From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 on 36xx with 2.6.34-rc6
Date: Mon, 10 May 2010 21:54:19 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E4049C6@dbde02.ent.ti.com>
References: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48033 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab0EJQYd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:24:33 -0400
In-Reply-To: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Steve Sakoman
> Sent: Monday, May 10, 2010 8:54 PM
> To: linux-omap@vger.kernel.org
> Subject: DSS2 on 36xx with 2.6.34-rc6
> 
> Has anyone had success with DSS2 on a 36xx platform using the current
> l-o top of tree?
> 
> I've been working with a Beagle xM prototype and have applied the
> "OMAP3630: DSS2: Updating MAX divider value" patch from Tomi's repo as
> well as Koen's Beagle DSS2 support patch.
> 
> The image works as expected on a 35xx based Beagle, but when run on
> the Beagle xM results in a "HDMI: Out of Range" error from my monitor.
>  Sadly the monitor won't give me the erroneous timing parameters.
> 
[Hiremath, Vaibhav] For me it looks like Timing related issue only. And if I understand correctly I have seen some mail-threads which were talking about successful bring-up on Beagle-XM board.

> I suspect that there are still issues in clock setup (or perhaps in
> CPU type/revision detection).
> 
> Anyone else working in this area?
[Hiremath, Vaibhav] Steve,

The AM/DM3730, which is exactly same as OMAP3630 has been supported with PSP releases. I would suggest you to refer to the Arago repo - 


http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary

Please note that similar kind of testing/validation has been done on AM/DM3730 platform.

Also please let me know if you have any issues.

Thanks,
Vaibhav

> 
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
