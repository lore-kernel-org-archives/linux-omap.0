From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Date: Fri, 16 Mar 2018 10:34:35 -0700
Message-ID: <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316172234.GA4212@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/16/2018 10:22 AM, Andrew Lunn wrote:
> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
>> one netdevice, as result such drivers will produce warning during system
>> boot and fail to connect second phy to netdevice when PHYLIB framework
>> will try to create sysfs link netdev->phydev for second PHY
>> in phy_attach_direct(), because sysfs link with the same name has been
>> created already for the first PHY.
>> As result, second CPSW external port will became unusable.
>> This issue was introduced by commits:
>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
>> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"
> 
> I wonder if it would be better to add a flag to the phydev that
> indicates it is the second PHY connected to a MAC? Add a bit to
> phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
> file.

We could indeed do that, I am fine with Grygorii's approach though in
making the creation more silent and non fatal.

> 
> For 99% of MAC drivers, having two PHYs is an error, so we want to aid
> debug by reporting the sysfs error.
That is true, either way is fine with me, really.
-- 
Florian
