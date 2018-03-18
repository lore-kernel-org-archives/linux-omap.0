From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Sun, 18 Mar 2018 14:13:27 +0100
Message-ID: <20180318131327.GD20139@kroah.com>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
 <20180316220835.30006-2-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180316220835.30006-2-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2018 at 05:08:34PM -0500, Grygorii Strashko wrote:
> The sysfs_create_link_nowarn() is going to be used in phylib framework in
> subsequent patch which can be built as module. Hence, export
> sysfs_create_link_nowarn() to avoid build errors.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")

This specific patch doesn't fix anything, it just _allows_ it to be
fixed in the second patch :)

Anyway, just a nit...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
