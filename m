From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 0/6] musb fixes for v4.9-rc cycle
Date: Fri, 11 Nov 2016 10:42:56 -0800
Message-ID: <20161111184302.2438-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are musb fixes for the issues that I've been able to track down.

As many people depend on this driver I'd like to have these merged
for v4.9-rc cycle after review and testing.

Please review and test. You need to use v4.9-rc3 or later for testing
because of the earlier fixes.

Changes since v1:

- Numerous changes to patch 2/4 for the sleeping function fix
  based on comments from Johan

- Two new patches to fix issues with devices not always
  enumerating by removing pointless PM runtime code

Regards,

Tony

Tony Lindgren (6):
  usb: musb: Fix broken use of static variable for multiple instances
  usb: musb: Fix sleeping function called from invalid context for hdrc
    glue
  usb: musb: Fix PM for hub disconnect
  phy: twl4030-usb: Fix for musb session bit based PM
  usb: musb: Add missing pm_runtime_disable and drop 2430 PM timeout
  usb: musb: Drop pointless PM runtime code for dsps glue

 drivers/phy/phy-twl4030-usb.c  |   4 +-
 drivers/usb/musb/musb_core.c   | 147 ++++++++++++++++++++++++++++++++++++-----
 drivers/usb/musb/musb_core.h   |  13 +++-
 drivers/usb/musb/musb_dsps.c   |  57 ++++++++--------
 drivers/usb/musb/musb_gadget.c |  39 +++++++++--
 drivers/usb/musb/omap2430.c    |  10 ++-
 drivers/usb/musb/tusb6010.c    |   6 +-
 7 files changed, 209 insertions(+), 67 deletions(-)

-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
