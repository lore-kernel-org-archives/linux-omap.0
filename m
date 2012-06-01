From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
Date: Fri, 1 Jun 2012 18:22:59 +0530
Message-ID: <CAAe_U6L6b26J4Q3mB6K0BLtwkaL92SFZSQTMCd=Rv3UBynVCBA@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
	<1338375394-16268-3-git-send-email-kishon@ti.com>
	<CAMQu2gxcP8At5j4UOK3bgX+Q+OunXeTxyXEr6hAhGiwjLs-gJg@mail.gmail.com>
	<4FC63B8D.3070107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:35031 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759678Ab2FAMxB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:53:01 -0400
Received: by ggnm2 with SMTP id m2so2033980ggn.13
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 05:52:59 -0700 (PDT)
In-Reply-To: <4FC63B8D.3070107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

Hi Benoit,

On Wed, May 30, 2012 at 8:53 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 5/30/2012 4:51 PM, Shilimkar, Santosh wrote:
>>
>> On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I<kishon@ti.co=
m>
>> =A0wrote:
>>>
>>> "ocp2scp_usb_phy_ick" clock node was a fake clock node created
>>> to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is no=
w
>>> added
>>> (which can be used to control MODULEMODE) this clock node is remove=
d.
>>>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 11 -----------
>>
>>
>> Have you patched clock44xx_data.c manually or you have a patch for
>> the clock_data autogen script to generate it ?
>
>
> I have a series that will remove all these clock nodes. I should be a=
ble to
> post that soon.
>
> Potentially at that time, Kishon might be able to drop that patch.

Will you be sending a patch for *[RFC PATCH 1/5] arm: omap: hwmod:
make *phy_48m* as the main_clk of ocp2scp* also or I have to keep that
as part of my series?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
