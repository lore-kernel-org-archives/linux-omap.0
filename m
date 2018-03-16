From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Date: Fri, 16 Mar 2018 14:41:50 -0500
Message-ID: <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/16/2018 02:11 PM, Florian Fainelli wrote:
> On March 16, 2018 11:42:21 AM PDT, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>>
>>
>> On 03/16/2018 12:34 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 03/16/2018 10:22 AM, Andrew Lunn wrote:
>>>> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>>>>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net
>> PHYs per
>>>>> one netdevice, as result such drivers will produce warning during
>> system
>>>>> boot and fail to connect second phy to netdevice when PHYLIB
>> framework
>>>>> will try to create sysfs link netdev->phydev for second PHY
>>>>> in phy_attach_direct(), because sysfs link with the same name has
>> been
>>>>> created already for the first PHY.
>>>>> As result, second CPSW external port will became unusable.
>>>>> This issue was introduced by commits:
>>>>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for
>> attached_dev/phydev"
>>>>> a3995460491d ("net: phy: Relax error checking on
>> sysfs_create_link()"
>>>>
>>>> I wonder if it would be better to add a flag to the phydev that
>>>> indicates it is the second PHY connected to a MAC? Add a bit to
>>>> phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
>>>> file.
>>>
>>> We could indeed do that, I am fine with Grygorii's approach though in
>>> making the creation more silent and non fatal.
>>
>> The link phydev->netdev still can be created. And failure to create
>> links
>> is non fatal error in my opinion.
> 
> They should not be fatal I agree, but it's nice to know when you are doing something wrong anyway.
> 
>>
>>>
>>>>
>>>> For 99% of MAC drivers, having two PHYs is an error, so we want to
>> aid
>>>> debug by reporting the sysfs error.
>>> That is true, either way is fine with me, really.
>>>
>>
>> Error still will be reported, just not warning and it will be
>> non-fatal.
>> So, with this patch set it will be possible now to continue boot (NFS
>> for example),
>> connect to the system and gather logs.
> 
> The point Andrew is trying to make is that you address one particular failure in the PHY creation path when using >
 1 PHY devices with a network device. Using a flag would easily allow us to be more future proof with other parts of PHYLIB
  for your particular use case if that becomes necessary. This gives you less incentive to fix this use case though.
> 

That's true, I'm fixing use case with >1 and I'll try to re-implement using flag as requested.
But note, this patch in its current form fixes 1:1 (phydev:netdev) use case also (at least as i understand it),
because current code will just kill net connection if create sysfs link fails, so in case of net boot -
failure logs will not be accessible without direct access to the device.

Actually, how can i pass this flag "<name of the flag>" from CPSW to of_phy_connect()->phy_attach_direct()?
The parameter "flags" == phy_device->dev_flags is used to pass PHY driver's specific options, so can't be used.

The phydrv->mdiodrv.flags can be accessible only after call to of_phy_connect()/phy_connect(), 
but sysfs links are created inside these functions.

Thanks.
-- 
regards,
-grygorii
