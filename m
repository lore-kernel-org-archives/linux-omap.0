From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] usb: musb: Power management support
Date: Fri, 25 Feb 2011 12:21:12 +0200
Message-ID: <20110225102112.GC4190@legolas.emea.dhcp.ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50950 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932425Ab1BYKVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 05:21:18 -0500
Content-Disposition: inline
In-Reply-To: <1298628663-27650-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Feb 25, 2011 at 03:40:58PM +0530, Hema HK wrote:
> This patch series supports the retention and offmode support in the 
> idle path for musb driver using runtime pm APIs.
> 
> This is restricted to support offmode and retention only when device not
> connected.When device/cable connected with gadget driver loaded, configured
> to no idle/standby which will not allow the core transition to retention
> or off.
> 
> There is no context save/restore done by hardware for musb in OMAP3
> and OMAP4,driver has to take care of saving and restoring the context
> during offmode.
> 
> Musb has a requirement of configuring sysconfig register to force
> idle/standby mode and set the ENABLE_FORCE bit in module STANDBY register
> for retention and offmode support.
> 
> Runtime pm and hwmod frameworks will take care of configuring to force
> idle/standby when pm_runtime_put_sync is called and back to no
> idle/standby when pm_runeime_get_sync is called.
> 
> Compile, boot tested and also tested the retention in the idle path on
> OMAP3630Zoom3. And tested the global suspend/resume with offmode enabled.
> Usb basic functionality tested on OMAP4430SDP.
> 
> There is some problem with idle path offmode in mainline, I could not test
> with offmode. But I have tested this patch with resetting the controller
> in the idle path when wakeup from retention just to make sure that the
> context is lost, and restore path is working fine.

please base this off of my for-next branch

-- 
balbi
