From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: AM335x ICE board Linux support
Date: Mon, 25 Apr 2016 14:59:22 +0300
Message-ID: <571E069A.20700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

We are working on getting Linux on AM335X Industrial Communication Engine board (ICE) [1].

This board has 2 Ethernet ports and each of them can be used either in RMII mode connected to
the CPSW Ethernet MAC *or* in MII mode connected to the PRU Ethernet MAC.

The decision about the Ethernet port's mode is made by the user by setting a jumper near the
Ethernet port before power up. This is a boot time configurable setting and doesn't need to
change at runtime.

So 4 configurations are possible:
    ETH0	ETH1
    ----	----
    RMII	RMII
    RMII	MII
    MII		RMII	(probably redundant and not needed)
    MII		MII

Based on the port configuration, software (u-boot or Linux) needs to set the right pinmux,
set a GPIOs (that controls external Mux), configure an external clock generator
and enable the right device driver for the respective Ethernet port.

Clock generator needs to be configured because different clock rates are required
for RMII vs MII mode.

Now question is how all this can be done on u-boot + Linux?

I already have a working solution where I create different DT blobs for the 3 configurations
and have u-boot detect the mode and load the correct DT blob and also configure the clock.

You can see how the kernel patches look like here [2]

Is this approach acceptable? If not is there any better way to do this? Thanks.

cheers,
-roger

[1] AM3359 ICE board
http://www.ti.com/tool/tmdsice3359
http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_%28ICE%29_EVM_HW_User_Guide

[2] Device tree patches
https://github.com/rogerq/linux/commit/9a9cf6a15f779fddf91dba2370627aabf19aeff5
https://github.com/rogerq/linux/commit/c87e8fa5b14f156a91883fd506e9dd8f7ccf95cf
https://github.com/rogerq/linux/commit/d9cdd25e8c3878292d7f4180af8d3ac42b9645c4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
