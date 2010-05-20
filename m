From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Thu, 20 May 2010 19:30:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DCC5F46@dbde02.ent.ti.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41431 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209Ab0ETOFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 10:05:09 -0400
In-Reply-To: <1274360966-9974-1-git-send-email-x0082077@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

Hi,

> Subject: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.

> Fix board data to support device only, host only and OTG roles.

 >The board data hardcodes the mode to OTG or Peripheral.
 >This fix will allow to use Peripheral, Host and OTG
 >roles independently.

 >Signed-off-by: Maulik Mankad <x0082077@ti.com>

Same set of code snippet getting repeated across the files. Isn't it good to have
them at same commom file usb-musb.c ?

 I think better remove .mode parameter from board_data if its not needed anyways if some board
 supports only some specific mode they can select those specifc config only.

-Ajay