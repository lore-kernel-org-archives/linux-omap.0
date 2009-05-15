From: twebb <taliaferro62@gmail.com>
Subject: how to configure android-2.6.27 kernel for an LCD display other than
	Zoom2 display
Date: Fri, 15 May 2009 15:18:11 -0400
Message-ID: <dbdb2ea60905151218v4b5b3299vbc7583ccedf0fc63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:41559 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbZEOTSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 15:18:10 -0400
Received: by pzk13 with SMTP id 13so1220385pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 12:18:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm using the L25.6/android-2.6.27 kernel and am adapting it as
necessary to OMAP3530-based hardware.  However, I don't see how to
configure the kernel for an LCD display other than the NEC display
defined for ZOOM2 (which is an SPI-based display?).  I'm using an LG
display via the dss_data[17:0] interface of the 35xx - and this is
working with a slightly modified version of lcd_omap3evm.c on the
linux-omap-2.6.27-omap1 kernel.  I'm not familiar with the new DSS
that appears to be in android-2.6.27.

The LG display is WSVGA, but I'd be happy getting WVGA or VGA working
on it for now.  How can I configure the kernel to support a
non-SPI-based LCD panel?  How does this DSS differ with what appears
in android-2.6.29/drivers/video/omap2 ?

Any help here would be appreciated.

Thanks,
twebb
