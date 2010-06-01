From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 07:47:34 +0300
Message-ID: <20100601044734.GB13883@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49012 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0FAEsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 00:48:08 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Mon, May 31, 2010 at 11:44:52PM +0200, ext Arce, Abraham wrote:
>+	pdata = kzalloc(sizeof(struct omap4_keypad_platform_data), GFP_KERNEL);

you will never free this.

[..]

>+	pdata->device_enable = omap_device_enable;

this is undefined at least here or previous patch.

>+	pdata->device_idle = omap_device_idle;

same for this

>+	pdata->device_shutdown = omap_device_shutdown;

and this.

-- 
balbi

DefectiveByDesign.org
