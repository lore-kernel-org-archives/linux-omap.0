From: "Basak, Partha" <p-basak2@ti.com>
Subject: On the APIs for Enabling and Disabling Wakeup capability.
Date: Wed, 16 Jun 2010 20:09:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56817 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab0FPOkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 10:40:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "paul@pwsan.com" <paul@pwsan.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Paul,

I wanted to close on the introduction of two new OMAP device APIs omap_device_enable_wakeup () & omap_device_disable_wakeup() in omap_device layer. 

These APIs are potentially needed by the USB driver (via function pointers) to work around some USB erratum.

Alternatively, can we call omap_hwmod_enable_wakeup() via function pointer? 
Is it agreeable to call these from driver code (via function pointers)in some special cases such as to handle some errata?

Thanks to clarify.
Partha
