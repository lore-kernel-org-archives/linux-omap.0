From: Kim Kyuwon <chammoru@gmail.com>
Subject: Suggestion regarding the ordering of GPIO MUX configurations
Date: Mon, 2 Mar 2009 11:37:14 +0900
Message-ID: <4d34a0a70903011837k2a1467b5s9c3b56e065d4b5c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:6858 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbZCBChQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2009 21:37:16 -0500
Received: by rv-out-0506.google.com with SMTP id g9so5104254rvb.5
        for <linux-omap@vger.kernel.org>; Sun, 01 Mar 2009 18:37:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>

Hi All.

The current order of GPIO mux configurations is not sorted. It seems
that all new GPIO MUX configurations are being inserted to the end as
shown in next code

/* arch/arm/plat-omap/include/mach/mux.h */
791         AH8_34XX_GPIO29,
792         J25_34XX_GPIO170,
793         AF26_34XX_GPIO0,
794         AF22_34XX_GPIO9,
795         L8_34XX_GPIO63,
796         AF6_34XX_GPIO140_UP,
797         AE6_34XX_GPIO141,
798         AF5_34XX_GPIO142,
799         AE5_34XX_GPIO143,
800         AG4_34XX_GPIO134,
801         U8_34XX_GPIO54,
802         AE4_34XX_GPIO136,


I wonder if we can sort the order of GPIO MUX configurations and then
insert new MUXs at right position. Can I ask your opinions?


Regards,

Kim Kyuwon.
-- 
Q1
