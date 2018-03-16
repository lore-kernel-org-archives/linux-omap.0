From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Fri, 16 Mar 2018 17:08:33 -0500
Message-ID: <20180316220835.30006-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
one netdevice, as result such drivers will produce warning during system
boot and fail to connect second phy to netdevice when PHYLIB framework
will try to create sysfs link netdev->phydev for second PHY
in phy_attach_direct(), because sysfs link with the same name has been
created already for the first PHY.
As result, second CPSW external port will became unusable.
This regression was introduced by commits:
5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"

Patch 1: exports sysfs_create_link_nowarn() function as preparation for Patch 2.
Patch 2: relaxes error checking when PHYLIB framework is creating sysfs
link netdev->phydev in phy_attach_direct(), suppresses warning by using
sysfs_create_link_nowarn() and adds error message instead, so links creation
failure is not fatal any more and system can continue working,
which fixes TI CPSW issue and makes boot logs accessible
in case of NFS boot, for example.

This can be stable material 4.13+.

Changes in v2:
- commit messages updated.

v1: 
 https://patchwork.ozlabs.org/cover/886058/

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Grygorii Strashko (2):
  sysfs: symlink: export sysfs_create_link_nowarn()
  net: phy: relax error checking when creating sysfs link netdev->phydev

 drivers/net/phy/phy_device.c | 15 +++++++++++----
 fs/sysfs/symlink.c           |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.10.5
