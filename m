From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Date: Thu, 15 Mar 2018 10:47:13 -0500
Message-ID: <add8a8dc-f417-d2ca-764b-07948d5d1c5b@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180314222624.12744-3-grygorii.strashko@ti.com>
 <20180315022637.GA20975@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315022637.GA20975@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/14/2018 09:26 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 14, 2018 at 05:26:24PM -0500, Grygorii Strashko wrote:
>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
>> one netdevice, as result such drivers will produce warning during system
>> boot and fail to connect second phy to netdevice when PHYLIB framework
>> will try to create sysfs link netdev->phydev for second PHY
>> in phy_attach_direct(), because sysfs link with the same name has been
>> created already for the first PHY. As result, second CPSW external
>> port will became unusable.
>>
>> Fix it by relaxing error checking when PHYLIB framework is creating sysfs
>> link netdev->phydev in phy_attach_direct(), suppressing warning by using
>> sysfs_create_link_nowarn() and adding debug message instead.
>>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/phy/phy_device.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 478405e..fe16f58 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -1012,10 +1012,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>>   	err = sysfs_create_link(&phydev->mdio.dev.kobj, &dev->dev.kobj,
>>   				"attached_dev");
>>   	if (!err) {
>> -		err = sysfs_create_link(&dev->dev.kobj, &phydev->mdio.dev.kobj,
>> -					"phydev");
>> -		if (err)
>> -			goto error;
>> +		err = sysfs_create_link_nowarn(&dev->dev.kobj,
>> +					       &phydev->mdio.dev.kobj,
>> +					       "phydev");
>> +		if (err) {
>> +			dev_err(&dev->dev, "could not add device link to %s err %d\n",
>> +				kobject_name(&phydev->mdio.dev.kobj),
>> +				err);
> 
> dev_err() is not a "debugging" message :)

Sry for the mess. I've originally did it as dev_dbg() after searching for
other occurrences of sysfs_create_link_nowarn() in kernel.
And honestly, I was unsure what to use dbg or err here.

> 
> What is a user going to do with this new error?  If it's not important
> at all, why care about it?

Now I think that dev_err() is better to use here:
1) It will notify about link creation error in other drivers (which is
still not critical as networking functionality will not be broken and device
will be able to boot (in case of NFS usage for example).
2) in case of TI CPSW driver we can live with this error message and
it will stimulate us (or any other user of this driver) to find time and
do fix/rework TI CPSW driver.

> 
>> +			/* non-fatal - some net drivers can use one netdevice
>> +			 * with more then one phy
>> +			 */
> 
> What about devices that do not have more than one phy and this call
> fails for?  Shouldn't you check for that?

As I mentioned before, this is not critical error. More over, as per code and
commit a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
- the error of creating link phydev->netdev already ignored in PHYLIB due to
"incorrect" initialization sequence of some network drivers.

if no objection i will repost after fixing commit messages. 

-- 
regards,
-grygorii
