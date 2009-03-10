From: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [2.6.29-rc7][take #2][PATCH 0/3] ARM: OMAP: Add command line option for I2C bus speed
Date: Tue, 10 Mar 2009 10:47:08 +0200
Message-ID: <1236674831-3637-1-git-send-email-jarkko.nikula@nokia.com>
References: <20090306161349.GC32353@atomide.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306161349.GC32353-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

These patches are for linux-omap but we want to wide discussion also to
linux-i2c is the new command line option "i2c_bus=bus_id,clkrate" generic
enough to be used for other architectures as well in the future. Patches
are generated on top of mainline 2.6.29-rc7.

Purpose of this command line option is to both allow to override the default
board specific bus speed (patch 2) and register additional busses that
are not registered from board initialization code (patch 3).

Example for patch 2 would be the case where some on board component is upgraded
and which allows to use e.g. higher clock rate on the bus without other major
board changes.

Patch 3 can have more practical use however. E.g. second I2C bus on TI
BeagleBoard doesn't have on board components and thus it is not registered
by default with omap_register_i2c_bus. This bus is routed to expansion pin
header so with this patch it is able to register dynamically when needed.

These patches are previously discussed in these threads:

http://marc.info/?l=linux-omap&m=123635604511892&w=2
http://marc.info/?l=linux-omap&m=123661915517228&w=2


-- 
Jarkko
