From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 0/2] ARM: dts: AM4372: Add more nodes
Date: Fri, 18 Oct 2013 08:56:44 +0200
Message-ID: <5260DBAC.6090107@baylibre.com>
References: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com> <5260AFB2.9010300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36897 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3JRG4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 02:56:48 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so483151wid.5
        for <linux-omap@vger.kernel.org>; Thu, 17 Oct 2013 23:56:47 -0700 (PDT)
In-Reply-To: <5260AFB2.9010300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mugunthanvnm@ti.com, sourav.poddar@ti.com, linux@arm.linux.org.uk, akpm@linux-foundation.org, rnayak@ti.com, afzal@ti.com, nsekhar@ti.com, r.sricharan@ti.com, balajitk@ti.com, balbi@ti.com

Hi Lokesh,

On 18/10/2013 05:49, Lokesh Vutla wrote:
> Hi Benoit,
> On Friday 11 October 2013 12:44 AM, Lokesh Vutla wrote:
>> This patch series add nodes for l2-cache-controller, EDMA, mailbox, =
mmc, sham,
>> and updates the properties for cpsw, i2c0, matrix-keypad.
>>
>> These patches are applied on top of Benoit's for_3.13/dts branch
>> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt=
=2Egit for_3.13/dts
> Can you take this patch series for 3.13?

I've just applied it after a sloght change in the subject and in the So=
B=20
list.

     ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes

     Populate nodes for l2-cache-controller, EDMA, mailbox,
     mmc, sham.

     Update as well DT properties for epwmss, aes, des.

     Signed-off-by: Suman Anna <s-anna@ti.com>
     Signed-off-by: Balaji T K <balajitk@ti.com>
     Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
     Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
     Signed-off-by: Benoit Cousson <bcousson@baylibre.com>


I added all the author you listed in a more formal way.

Regards,
Benoit

>
> Thanks and regards,
> Lokesh
>>
>> Testing:
>> Tested EDMA, mmc, sham, aes, des, i2c0, cpsw, matric-keypad on AM437=
2 EPOS EVM
>> with the addition of following two series:
>> -> Tero's V8 of OMAP DT clock conversion
>>    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96769.h=
tml
>> -> Afzal's V5 of AM43x PRCM basic support
>>    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96275.h=
tml
>>
>> Lokesh Vutla (1):
>>    ARM: dts: AM4372: Add more nodes
>>
>> Mugunthan V N (1):
>>    ARM: dts: AM4372: Update Support for EPOS EVM
>>
>>   arch/arm/boot/dts/am4372.dtsi        |  210 ++++++++++++++++++++++=
+++++++++++-
>>   arch/arm/boot/dts/am43x-epos-evm.dts |  168 ++++++++++++++++++++++=
+++++
>>   include/dt-bindings/pinctrl/am43xx.h |   31 +++++
>>   3 files changed, 408 insertions(+), 1 deletion(-)
>>   create mode 100644 include/dt-bindings/pinctrl/am43xx.h
>>
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
