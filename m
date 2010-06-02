From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH v3 3/4] OMAP4: Keyboard board support
Date: Wed, 2 Jun 2010 07:26:46 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E538A88@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F75@dlee03.ent.ti.com>
 <20100601044813.GC13883@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53156 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033Ab0FBM04 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 08:26:56 -0400
In-Reply-To: <20100601044813.GC13883@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Felipe,

> >+static struct omap4_keypad_platform_data sdp4430_keypad_data = {
> >+	.keymap_data		= &sdp4430_keymap_data,
> >+	.rows			= 8,
> >+	.cols			= 8,
> >+	.device_enable		= omap_device_enable,
> >+	.device_shutdown	= omap_device_shutdown,
> >+	.device_idle		= omap_device_idle,
> 
> again all three are undefined
> 

To be removed...

