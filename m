From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [balbi-usb:testing/next 25/25]
 drivers/usb/renesas_usbhs/rcar3.c:115:5: sparse: symbol
 'usbhs_rcar3_notifier' was not declared. Should it be static?
Date: Thu, 14 Dec 2017 01:20:52 +0800
Message-ID: <201712140134.kYd2nFKY%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
head:   3a7cce26122e3925993ee2ac0b45ac6b9bf6f65f
commit: 3a7cce26122e3925993ee2ac0b45ac6b9bf6f65f [25/25] usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel
reproduce:
        # apt-get install sparse
        git checkout 3a7cce26122e3925993ee2ac0b45ac6b9bf6f65f
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
