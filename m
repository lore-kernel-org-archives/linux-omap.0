From: Michael Welling <mwelling@emacinc.com>
Subject: TSC2004 driver
Date: Tue, 5 Aug 2014 12:06:40 -0500
Message-ID: <20140805170640.GA8830@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33997 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbaHERGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2014 13:06:47 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so1418550ieb.35
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2014 10:06:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, hvaibhav@ti.com

The TSC2004 driver has yet to appear in the mainline kernel. We have
been using the driver referenced here as provided by TI:

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg22018.html

Are there any plans of supporting this device in the mainline kernel?

Mysteriously a device tree entry was found in the following file:
arch/arm/boot/dts/omap4-var-som-om44.dtsi

This is obviously pointing to an out of tree driver that is not easily
obtained.

Suggestions?
