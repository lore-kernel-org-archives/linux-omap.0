From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 5/5 v9] mfd: omap: usb: Runtime PM support
Date: Fri, 16 Sep 2011 11:17:42 +0530
Message-ID: <CAP05o4JK9zdZ8P5o0Di+obDwYjur0p=TC-n9weznqx_odMzycw@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-2-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-3-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-4-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-5-git-send-email-keshava_mgowda@ti.com>
	<1316092970-2440-6-git-send-email-keshava_mgowda@ti.com>
	<4E729AFB.6010008@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42940 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308Ab1IPFro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 01:47:44 -0400
In-Reply-To: <4E729AFB.6010008@am.sony.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: frank.rowand@am.sony.com
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "gadiyar@ti.com" <gadiyar@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@ti.com" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "vishwanath.bs@ti.com" <vishwanath.bs@ti.com>

On Fri, Sep 16, 2011 at 6:10 AM, Frank Rowand <frank.rowand@am.sony.com=
> wrote:
> On 09/15/11 06:22, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> The usbhs core driver does not enable/disable the interface and
>> functional clocks; These clocks are handled by hwmod and runtime pm,
>> hence instead of the clock enable/disable, the runtime pm APIS are
>> used. however,the port clocks are handled by the usbhs core.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A03 -
>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0731 ++++++++=
+++++--------------------
>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0| =A0 17 +-
>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 | =A0 18 +-
>> =A04 files changed, 295 insertions(+), 474 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-o=
map/include/plat/usb.h
>> index 17d3c93..2b66dc2 100644
>
> Patch 5/5 is white space mangled. =A0The tabs have been changed into =
spaces.
>
> -Frank

where exactly? I had checked before sending it , but i dint find any?
please let me know where exactly.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
