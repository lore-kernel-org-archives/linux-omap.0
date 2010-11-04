From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] smsc911x: Set Ethernet EEPROM size to supported
 device's size
Date: Wed, 03 Nov 2010 18:57:47 -0700 (PDT)
Message-ID: <20101103.185747.102567051.davem@davemloft.net>
References: <1288647008-11846-1-git-send-email-jfaith7@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37018
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754750Ab0KDB5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 21:57:23 -0400
In-Reply-To: <1288647008-11846-1-git-send-email-jfaith7@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jfaith7@gmail.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

From: John Faith <jfaith7@gmail.com>
Date: Mon,  1 Nov 2010 14:30:08 -0700

> The SMSC911x supports 128 x 8-bit EEPROMs.  Increase the EEPROM size
> so more than just the MAC address can be stored.
> 
> Signed-off-by: John Faith <jfaith7@gmail.com>

Applied.
