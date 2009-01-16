From: Krishna Kishore <krishna.kishore@sasken.com>
Subject: RE: OMAP3430 clock settings
Date: Fri, 16 Jan 2009 13:38:18 +0530
Message-ID: <F9F1042FDECC134ABFBF4EC5EBEC88DAB35993@EXGZ02.sasken.com>
References: <1231897985-5274-1-git-send-email-stanley.miao@windriver.com> <F9F1042FDECC134ABFBF4EC5EBEC88DAB35794@EXGZ02.sasken.com> <8F7AF80515AF0D4D93307E594F3CB40E1A5F6003@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr1.sasken.com ([203.200.200.72]:26491 "EHLO
	mta-blr1.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbZAPISZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:18:25 -0500
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org


Hi Hari,

  Thanks for providing this utility.

  This is useful to read the values of registers from user space.

  Can you please help us further by letting us know how to find out 
  clock speeds of DSP, ARM, L3?

  There are some multiplication factors to be used to arrive at
  clock speeds. Can you please let us know the procedure since it is 
  already known?

Regards,
Kishore. 

-----Original Message-----
From: Kanigeri, Hari [mailto:h-kanigeri2@ti.com] 
Sent: Thursday, January 15, 2009 10:25 PM
To: Krishna Kishore; linux-omap@vger.kernel.org
Subject: RE: OMAP3430 clock settings


Kishore,

>    We need to find this out during runtime. Which register to read and

> how to
>    know the clock settings of DSP, ARM and L3?

-- You can use this small utility to read/write/dump register values
from user space. This is only for debug purpose if you want to peek and
poke at some registers from user space.

https://omapzoom.org/gf/download/frsrelease/152/964/debuginfo.out

The usage is

For reading
./debuginfo.out r  <Hex registerAddress without 0x prefix>
<regAccessSize =8, 16, 32>

Eg: to read PM_PWSTCTRL_IVA2 register, it would be ./debuginfo.out r
483060E0 32

For writing
 # ./debuginfo.out  w <Hex registerAddress without 0x prefix>
<regAccessSize =8, 16, 32> <value>

Eg: to write to PM_PWSTCTRL_IVA2 register, it would be ./debuginfo.out w
483060E0 32 <value>

For Dump
 # ./debuginfo.out a  <Hex registerAddress without 0x prefix>
<numOfWordsToDump>

Eg: To dump first 100 values of IVA2_PRM registers ./debuginfo.out a
48306000 100

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap- 
> owner@vger.kernel.org] On Behalf Of Krishna Kishore
> Sent: Wednesday, January 14, 2009 1:41 AM
> To: linux-omap@vger.kernel.org
> Subject: OMAP3430 clock settings
> 
> 
> Hi,
> 
>    How do we find out clock settings on OMAP3430?
> 
>    We need to find this out during runtime. Which register to read and

> how to
>    know the clock settings of DSP, ARM and L3?
> 
> Regards,
> Kishore.
> SASKEN BUSINESS DISCLAIMER
> -------------------------
> This message may contain confidential, proprietary or legally 
> privileged information. In case you are not the original intended 
> Recipient of the message, you must not, directly or indirectly, use, 
> Disclose, distribute, print, or copy any part of this message and you 
> are requested to delete it and inform the sender. Any views expressed 
> in this message are those of the individual sender unless otherwise 
> stated. Nothing contained in this message shall be construed as an 
> offer or acceptance of any offer by Sasken Communication Technologies 
> Limited ("Sasken") unless sent with that express intent and with due 
> authority of Sasken. Sasken has taken enough precautions to prevent 
> the spread of viruses. However the company accepts no liability for 
> any damage caused by any virus transmitted by this email
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged information. In 
case you are not the original intended Recipient of the message, you must not, directly or 
indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
requested to delete it and inform the sender. Any views expressed in this message are 
those of the individual sender unless otherwise stated. Nothing contained in this message 
shall be construed as an offer or acceptance of any offer by Sasken Communication 
Technologies Limited ("Sasken") unless sent with that express intent and with due 
authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
viruses. However the company accepts no liability for any damage caused by any virus 
transmitted by this email

