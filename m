From: Cliff Brake <cliff.brake@gmail.com>
Subject: omap_musb_board_data -- trouble specifying 500mA supply
Date: Wed, 28 Apr 2010 10:10:20 -0400
Message-ID: <r2of96d234e1004280710p91c1aa1cg41c1a1f96c7d461e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39296 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0D1OK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 10:10:26 -0400
Received: by gwj19 with SMTP id 19so4800372gwj.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 07:10:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

Hello,

We are designing a custom OMAP board that will have a 500mA supply on
the OTG port.  It looks like the power is set with:

struct omap_musb_board_data {
	u8	interface_type;
	u8	mode;
	u8	power;
};

However, with a u8, the max value is 255.  Should power be changed to a u16?

Thanks,
Cliff
