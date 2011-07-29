From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Fri, 29 Jul 2011 19:11:34 +0530
Message-ID: <4E32B88E.6030508@ti.com>
References: <1311940122-10681-1-git-send-email-shubhrajyoti@ti.com> <20110729120711.GL31013@legolas.emea.dhcp.ti.com> <4E32A75C.5060400@warmcat.com> <20110729123716.GN31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:51271 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753436Ab1G2Nln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 09:41:43 -0400
In-Reply-To: <20110729123716.GN31013@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, santosh.shilimkar@ti.com

On Friday 29 July 2011 06:07 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Jul 29, 2011 at 01:28:12PM +0100, "Andy Green (=E6=9E=97=E5=AE=
=89=E5=BB=B8)" wrote:
>> On 07/29/2011 01:07 PM, Somebody in the thread at some point said:
>>
>> Hi -
>>
>>> -                       omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, de=
v->westate);
>>> +                       if (dev->rev<   OMAP_I2C_REV_ON_3530_4430)
>>> +                               omap_i2c_write_reg(dev, OMAP_I2C_WE=
_REG,
>>> +                                                               dev=
->westate);
>>> Andy, can you clarify why you added the revision check which didn't
>>> exist before ?
>>>
>>> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-=
pm.git;a=3Dcommitdiff;h=3Da3a7acbcc3df4e9ecc12aa1fc435534d74ebbdf4
>>>
>> At the time I wrote the patches back in March, the code there was
>> different: there was a pre-extant test avoiding that line on 4430,
>> and the patch is simply converting it to the new scheme.  You can se=
e
>> it here:
>>
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/54940
>>
>> @@ -379,7 +379,7 @@ static int omap_i2c_init(struct omap_i2c_dev *de=
v)
>>   			 * REVISIT: Some wkup sources might not be needed.
>>   			 */
>>   			dev->westate =3D OMAP_I2C_WE_ALL;
>> -			if (dev->rev<  OMAP_I2C_REV_ON_4430)
>> +			if (dev->rev<  OMAP_I2C_REV_ON_3530_4430)
>>   				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>>   								dev->westate);
>>   		}
>>
>> I guess since March and before this got committed for 3.1, someone
>> got a patch in first removing the test, so when my patchset was
>> uplevelled for commit against 3.1-rc this conflict was dealt with by
>> re-introducing the test.
>>
>> Long story short, it's there from me as a mechanical 1:1 renaming
>> action as part of the fix that 3530 and 4430 (different) IPs return
>> the same rev number.  Despite how it now looks I didn't add it, so i=
f
>> Shubhrajyoti has reasons to think it should be gone again I have
>> nothing against that at all.
> yeah, looks like a bad conflict resolution. Shubhrajyoti, care to res=
pin
> the patch and update commit log stating that it is fixing a bad confl=
ict
> resolution or something ?
I wasn't aware of the conflict resolution part. Actually came across th=
is
piece of code as per the discussion on the reset implementation patch=20
will update
the changelogs.
How about,

=46rom: Shubhrajyoti D<shubhrajyoti@ti.com>

Currently for OMAP4 the I2C_WE is not programmed.
This patch enables the programming for OMAP4.

=46ixes a conflict resolution of Andy's patches.

Reported-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
---
TODO:
Currently all the wakeup sources are enabled.
There is scope of optimising the same. Will revisit it.
Rebased on Kevin's wip/i2c branch
Tested on OMAP4430.

  drivers/i2c/busses/i2c-omap.c |    5 ++---
  1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index d05efe7..18cc0af 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -313,9 +313,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
  		 * REVISIT: Some wakeup sources might not be needed.
  		 */
  		dev->westate =3D OMAP_I2C_WE_ALL;
-		if (dev->rev<  OMAP_I2C_REV_ON_3530_4430)
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							dev->westate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+						dev->westate);
  	}
  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

-- 1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
