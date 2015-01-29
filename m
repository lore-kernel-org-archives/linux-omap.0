From: Ash Charles <ashcharles@gmail.com>
Subject: Supporting two SMSC9221 interfaces on GPMC in a dts
Date: Wed, 28 Jan 2015 18:49:21 -0800
Message-ID: <CAK8F28=sANBtwDdg45MuVmrE89SBYtzBsZcPZoXo=AhOv0wpOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53801 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbbA2Ctw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2015 21:49:52 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so28207482ieb.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2015 18:49:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi,

The Gumstix Tobi-Duo board has two SMSC9221 NICs attached to the GPMC
interface of an OMAP3.  I'm trying to figure out how best to include
both interfaces in the device tree file.
With just one interface, I can #include "omap-gpmc-smsc9221.dtsi", add
the extra board specific settings in to "ethernet@gpmc" in the board
file as well as any settings needed for the gpmc.

For two interfaces though, I can setup the gpmc details, configure one
"ethernet@gpmc" node as before but then, need to manually create (i.e.
copy the meat from the "omap-gpmc-smsc9221.dtsi") a second node.

This works but seems, well, verbose.  Is there a way to setup multiple
interfaces without having to duplicate the omap-gpmc-smsc9221.dtsi
content?

Any hints much appreciated!  Thanks,

--Ash
