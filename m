From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus: tahvo: Select USB_OTG_UTILS
Date: Tue, 19 Apr 2011 13:05:39 +0300
Message-ID: <20110419100538.GC28899@legolas.emea.dhcp.ti.com>
References: <1303201178-11482-1-git-send-email-jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53127 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753108Ab1DSKFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 06:05:42 -0400
Received: by mail-fx0-f42.google.com with SMTP id 1so5048773fxm.15
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 03:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303201178-11482-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Apr 19, 2011 at 11:19:38AM +0300, Jarkko Nikula wrote:
> tahvo-usb.c is using otg_set_transceiver which is built only if
> CONFIG_USB_OTG_UTILS is set.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

FWIW:

Reviewied-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
