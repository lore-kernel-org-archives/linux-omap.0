From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] Enable Mailboxes for AM57xx IDKs
Date: Fri, 19 May 2017 15:47:40 -0500
Message-ID: <20170519204742.1563-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This series enables the mailbox nodes to be used for communicating with
the DSPs and IPUs on AM57xx IDKs using IPC 3.x. The mailbox nodes themselves
were already defined/added before for other DRA7 boards, and these patches
simply enable the respective nodes for the IDKs.

Patches are based on 4.12-rc1 and are intended for the 4.13 merge
window.

regards
Suman

Suman Anna (2):
  ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
  ARM: dts: am571x-idk: Enable the system mailboxes 5 and 6

 arch/arm/boot/dts/am571x-idk.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
