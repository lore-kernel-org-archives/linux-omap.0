From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8] ARM: dts: fixes for DT warnings on OMAP2+ platforms
Date: Mon, 4 Apr 2016 18:16:05 +0300
Message-ID: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This set fixes the clock node related warnings for OMAP2+ platforms
that are going to be introduced with the new version of DTC that
does stricter checks on DT structure. Basically, the address component
is currently missing on the node names that have a reg properly, which
is illegal.

Set applied on top of 4.6-rc2. Pushed branch here also:

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.6-rc2-clk-dt-warn-fixes

Boot tested on following boards:

  : Board           : Boot WRN version                 
 1: am335x-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
 2: am335x-evmsk    : PASS   0 4.6.0-rc2-00008-gadb720d
 3: am3517-evm      : PASS   1 4.6.0-rc2-00008-gadb720d
 4: am37x-evm       : PASS   0 4.6.0-rc2-00008-gadb720d
 5: am437x-sk       : PASS   0 4.6.0-rc2-00008-gadb720d
 6: am43x-epos-evm  : FAIL   0 4.6.0-rc2-00008-gadb720d
 7: am437x-gp-evm   : PASS   0 4.6.0-rc2-00008-gadb720d
 8: am57xx-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
 9: omap3-beagle-xm : PASS   0 4.6.0-rc2-00008-gadb720d
10: omap3-beagle    : PASS   0 4.6.0-rc2-00008-gadb720d
11: am335x-boneblack: PASS   0 4.6.0-rc2-00008-gadb720d
12: am335x-bone     : PASS   0 4.6.0-rc2-00008-gadb720d
13: craneboard      : PASS   1 4.6.0-rc2-00008-gadb720d
14: dra72x-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
15: dra7xx-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
16: ldp3430         : PASS   0 4.6.0-rc2-00008-gadb720d
17: omap3-n900      : FAIL   0                         
18: omap5-uevm      : FAIL   0                         
19: omap4-panda-es  : PASS   0 4.6.0-rc2-00008-gadb720d
20: omap4-panda     : PASS   0 4.6.0-rc2-00008-gadb720d
21: omap2430-sdp    : PASS   0 4.6.0-rc2-00008-gadb720d
22: omap3430-sdp    : PASS   0 4.6.0-rc2-00008-gadb720d
23: omap4-sdp-es23plus: PASS   0 4.6.0-rc2-00008-gadb720d
TOTAL = 23 boards, Booted Boards = 20, No Boot boards = 3

The boot failures detected are caused by board defects on the test
farm I am using, except for the am43xx-epos, which is a known issue
(syntimer fix still missing from -rc2.)

Also ran a quick suspend/resume test on omap3/omap4 and that seems
to be working fine also.

-Tero

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
