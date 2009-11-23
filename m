From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 panel question
Date: Mon, 23 Nov 2009 13:04:47 +0200
Message-ID: <1258974287.2438.76.camel@tubuntu.research.nokia.com>
References: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45376 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbZKWLFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 06:05:09 -0500
In-Reply-To: <6ed0b2680911210716l529e02ck23e188417fecd4f1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, 2009-11-21 at 16:16 +0100, ext Grazvydas Ignotas wrote:
> Hello,
> 
> I've been updating Pandora's panel for upstream-going DSS2, which now
> uses device/device_driver model for panels. The thing is that the
> panel we use is SPI controlled, so it needs to be set up as
> spi_driver. From SPI probe function I can do
> omap_dss_register_driver(), but how do I pass SPI data to
> omap_dss_device cleanly? Surely some globals would help, but this is
> not a "clean" way I guess. There used to be panel-n800.c with similar
> requirements, but it's not yet converted, right? Do you have any ideas
> how this can be done?

I don't have any good answer for this. For N900's panel there was a
static global variable, if I remember right. Not very clean, as you
said.

 Tomi


