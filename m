From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Fri, 16 Mar 2018 12:11:15 -0700
Message-ID: <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com> <20180316172234.GA4212@lunn.ch> <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com> <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On March 16, 2018 11:42:21 AM PDT, Grygorii Strashko <grygorii=2Estrashko@t=
i=2Ecom> wrote:
>
>
>On 03/16/2018 12:34 PM, Florian Fainelli wrote:
>>=20
>>=20
>> On 03/16/2018 10:22 AM, Andrew Lunn wrote:
>>> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>>>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net
>PHYs per
>>>> one netdevice, as result such drivers will produce warning during
>system
>>>> boot and fail to connect second phy to netdevice when PHYLIB
>framework
>>>> will try to create sysfs link netdev->phydev for second PHY
>>>> in phy_attach_direct(), because sysfs link with the same name has
>been
>>>> created already for the first PHY=2E
>>>> As result, second CPSW external port will became unusable=2E
>>>> This issue was introduced by commits:
>>>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for
>attached_dev/phydev"
>>>> a3995460491d ("net: phy: Relax error checking on
>sysfs_create_link()"
>>>
>>> I wonder if it would be better to add a flag to the phydev that
>>> indicates it is the second PHY connected to a MAC? Add a bit to
>>> phydrv->mdiodrv=2Eflags=2E If that bit is set, don't create the sysfs
>>> file=2E
>>=20
>> We could indeed do that, I am fine with Grygorii's approach though in
>> making the creation more silent and non fatal=2E
>
>The link phydev->netdev still can be created=2E And failure to create
>links
>is non fatal error in my opinion=2E=20

They should not be fatal I agree, but it's nice to know when you are doing=
 something wrong anyway=2E

>
>>=20
>>>
>>> For 99% of MAC drivers, having two PHYs is an error, so we want to
>aid
>>> debug by reporting the sysfs error=2E
>> That is true, either way is fine with me, really=2E
>>=20
>
>Error still will be reported, just not warning and it will be
>non-fatal=2E
>So, with this patch set it will be possible now to continue boot (NFS
>for example),
>connect to the system and gather logs=2E

The point Andrew is trying to make is that you address one particular fail=
ure in the PHY creation path when using > 1 PHY devices with a network devi=
ce=2E Using a flag would easily allow us to be more future proof with other=
 parts of PHYLIB  for your particular use case if that becomes necessary=2E=
 This gives you less incentive to fix this use case though=2E

--=20
Florian
