From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Wed, 16 Jun 2010 20:28:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BD6@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024Ab0FPO7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 10:59:02 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Kalliguddi, Hema" <hemahk@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Basak, Partha
> Sent: Wednesday, June 16, 2010 8:10 PM
> To: paul@pwsan.com
> Cc: khilman@deeprootsystems.com; Kalliguddi, Hema; Nayak, Rajendra; linux-
> omap@vger.kernel.org
> Subject: On the APIs for Enabling and Disabling Wakeup capability.
> 
> Hello Paul,
> 
> I wanted to close on the introduction of two new OMAP device APIs
> omap_device_enable_wakeup () & omap_device_disable_wakeup() in omap_device
> layer.

We also need the API omap_hwmod_set_slave_idlemode to be exposed as an omap_device API. 

Net-net, the following APIs which are exported in hwmod layer needs to be wrapped under omap_device_layer as well so that drivers can use them:
omap_hwmod_enable_wakeup
omap_hwmod_disable_wakeup
omap_hwmod_set_slave_idlemode

> 
> These APIs are potentially needed by the USB driver (via function
> pointers) to work around some USB erratum.
> 
> Alternatively, can we call omap_hwmod_enable_wakeup() via function
> pointer?
> Is it agreeable to call these from driver code (via function pointers)in
> some special cases such as to handle some errata?
> 
> Thanks to clarify.
> Partha
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
