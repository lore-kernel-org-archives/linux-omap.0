From: Keerthy <j-keerthy@ti.com>
Subject: Re: AM43x boot broken on linux-next
Date: Wed, 10 Jan 2018 16:08:16 +0530
Message-ID: <5f709e77-706b-2b03-3551-b7ad6acf579a@ti.com>
References: <bf1fc3d2-b882-7850-4afd-c1e753e2a1a7@ti.com>
 <b79af9ad-e238-50ec-ef85-62957b267de8@ti.com>
 <07c3e621-7f4a-0574-a8e9-76ffe519456e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <07c3e621-7f4a-0574-a8e9-76ffe519456e@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, rmk+kernel@armlinux.org.uk, tony@atomide.com
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, nm@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 10 January 2018 03:47 PM, Keerthy wrote:
> 
> 
> On Tuesday 09 January 2018 03:22 PM, Keerthy wrote:
>> On Tuesday 09 January 2018 02:03 PM, Keerthy wrote:
>>> Hi,
>>
>> Adding netdev@vger.kernel.org
>>
>>>
>>> Seems like AM437x boot is broken on latest linux-next.
>>> Log here:
>>>
>>> https://pastebin.ubuntu.com/26351906/
> 
> Git bisect pointed me to this patch:
> 
> commit fea23fb591cce99546baca043d2a068228e87a79
> Author: Russell King <rmk+kernel@armlinux.org.uk>
> Date:   Tue Jan 2 10:58:58 2018 +0000
> 
>     net: phy: convert read-modify-write to phy_modify()
> 
> I saw that there was a double negation issue there and i moved to
> Russell's fix patch:
> 
> commit f102852f980eac250855504c18f195900616deec
> Author: Russell King <rmk+kernel@armlinux.org.uk>
> Date:   Fri Jan 5 16:07:10 2018 +0000
> 
>     net: phy: fix wrong masks to phy_modify()
> 
> Even with this fix commit i am seeing issues.
> 
> I reverted the fix and the original patch on linux-next and that solves
> the issue.
> 
> So there is more to fix in the original patch IMHO.

Russell,

I found at least one issue with the logic of the original patch here:

@@ -1368,9 +1368,8 @@ static int genphy_config_eee_advert(struct
phy_device *phydev)
  */
 int genphy_setup_forced(struct phy_device *phydev)
 {
-	int ctl = phy_read(phydev, MII_BMCR);
+	u16 ctl = 0;

-	ctl &= BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN;
 	phydev->pause = 0;
 	phydev->asym_pause = 0;

@@ -1382,7 +1381,8 @@ int genphy_setup_forced(struct phy_device *phydev)
 	if (DUPLEX_FULL == phydev->duplex)
 		ctl |= BMCR_FULLDPLX;

-	return phy_write(phydev, MII_BMCR, ctl);
+	return phy_modify(phydev, MII_BMCR,
+			  BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN, ctl);

IMO the original intent of the genphy_setup_forced function was to
preserve the states of BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN bits
and clear all other bits..

But after your patch we are deliberately clearing those flags.

So the mask here needs to be negated.

return phy_modify(phydev, MII_BMCR, ~(BMCR_LOOPBACK | BMCR_ISOLATE
    |BMCR_PDOWN), ctl);

This is at least one more fix. Even after this fix boot is still broken.
So there is more to dig.

Regards,
Keerthy

> 
>>>
>>> "Unable to handle kernel paging request at virtual address 000013e8
>>> [    2.367045] pgd = c0350bf7
>>> [    2.370019] [000013e8] *pgd=00000000
>>> [    2.373823] Internal error: Oops: 5 [#1] SMP ARM
>>> [    2.378709] Modules linked in:
>>> [    2.381949] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>> 4.15.0-rc6-next-20180108-38410-g895c0dd #4
>>> [    2.391242] Hardware name: Generic AM43 (Flattened Device Tree)
>>> [    2.397523] PC is at phy_attached_print+0xc/0x10c
>>> [    2.402506] LR is at cpsw_slave_open+0x16c/0x258"
>>>
>>> Regards,
>>> Keerthy
>>>
