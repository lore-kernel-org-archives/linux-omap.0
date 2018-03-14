From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Wed, 14 Mar 2018 17:26:23 -0500
Message-ID: <20180314222624.12744-2-grygorii.strashko@ti.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314222624.12744-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The sysfs_create_link_nowarn() is going to be used in phylib framework in
suseuent patch which can be built as module. Hence, export
sysfs_create_link_nowarn() to avoid build errors.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
"Fixes" added as there is dependency this and subsequent patch.
 fs/sysfs/symlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index 8664db2..215c225 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -106,6 +106,7 @@ int sysfs_create_link_nowarn(struct kobject *kobj, struct kobject *target,
 {
 	return sysfs_do_create_link(kobj, target, name, 0);
 }
+EXPORT_SYMBOL_GPL(sysfs_create_link_nowarn);
 
 /**
  *	sysfs_delete_link - remove symlink in object's directory.
-- 
2.10.5
