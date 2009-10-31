From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: EHCI on 2.6.32-rc5-git4 + patches
Date: Sat, 31 Oct 2009 22:38:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
References: <4AEC544A.4000304@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57868 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbZJaRKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 13:10:52 -0400
In-Reply-To: <4AEC544A.4000304@blueyonder.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "sboyce@blueyonder.co.uk" <sboyce@blueyonder.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sid Boyce wrote:
> There is no way to configure EHCI on beagleboard, so my devices are
> never seen. Only OHCI has ARCH_ARM as a config option.
> I shall edit it into drivers/usb/Kconfig and see if it works.

drivers/usb/Kconfig looks okay to me.

<http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=drivers/usb/Kconfig;h=5620e924a218da2bc5e03124934f339095dd18da;hb=HEAD>

See line 63 - it says USB_ARCH_HAS_EHCI is y if ARCH_OMAP34XX

- Anand


