From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: pandora: fix usbhs platform data
Date: Mon, 5 Mar 2012 11:42:15 -0800
Message-ID: <20120305194215.GN12083@atomide.com>
References: <1329604985-24740-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56824 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434Ab2CETmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:42:18 -0500
Content-Disposition: inline
In-Reply-To: <1329604985-24740-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120218 14:11]:
> It turned out wrong OMAP HSUSB port was configured on pandora,
> but still managed to work somehow. This was noticed after enabling
> in-kernel mux, where USB muxing was causing other devices not to work,
> because hsusb1 pins (instead of hsusb2) were wrongly remuxed, which
> are used for other things on pandora.

Thanks, adding this to fixes-non-critical-part2.

Regards,

Tony
