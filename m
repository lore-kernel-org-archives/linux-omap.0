From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] net: phy: relax error checking when creating
 sysfs link netdev->phydev
Date: Mon, 19 Mar 2018 21:15:12 -0400 (EDT)
Message-ID: <20180319.211512.2145226173040811016.davem@davemloft.net>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316220835.30006-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, gregkh@linuxfoundation.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 16 Mar 2018 17:08:33 -0500

> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
> one netdevice, as result such drivers will produce warning during system
> boot and fail to connect second phy to netdevice when PHYLIB framework
> will try to create sysfs link netdev->phydev for second PHY
> in phy_attach_direct(), because sysfs link with the same name has been
> created already for the first PHY.
> As result, second CPSW external port will became unusable.
> This regression was introduced by commits:
> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
> a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"
> 
> Patch 1: exports sysfs_create_link_nowarn() function as preparation for Patch 2.
> Patch 2: relaxes error checking when PHYLIB framework is creating sysfs
> link netdev->phydev in phy_attach_direct(), suppresses warning by using
> sysfs_create_link_nowarn() and adds error message instead, so links creation
> failure is not fatal any more and system can continue working,
> which fixes TI CPSW issue and makes boot logs accessible
> in case of NFS boot, for example.

Series applied and queued up for -stable, thanks.
