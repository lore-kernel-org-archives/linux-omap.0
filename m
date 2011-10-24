From: James <angweiyang@gmail.com>
Subject: Simple GPMC device driver with basic User application
Date: Mon, 24 Oct 2011 09:47:02 +0800
Message-ID: <CAOy7-nMMyk3kMc9aShigxuvdB5O3S+B319SCR36kzM0ZTmSQ6w@mail.gmail.com>
References: <CAOy7-nNxRgB21JSFcWvD4T3AwDDuh9MjBeB+8nFiwX-Cv+13Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35157 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab1JXBrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Oct 2011 21:47:04 -0400
Received: by wyg36 with SMTP id 36so5669087wyg.19
        for <linux-omap@vger.kernel.org>; Sun, 23 Oct 2011 18:47:02 -0700 (PDT)
In-Reply-To: <CAOy7-nNxRgB21JSFcWvD4T3AwDDuh9MjBeB+8nFiwX-Cv+13Mw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear all,

I'm learning embedded linux development and need help on my task.

I'm trying to communicate with a FPGA via the GPMC bus on my Overo FE
board and need assistance with writing a simple device driver & test
application that uses the GPMC bus to read & write a WORD size data
and also a BLOCK of WORD data to the FPGA.

The FPGA-OMAP3530 will be use synchronous read/write over the 16-bit
datapath and CS 6.
The GPMC bus is shared with an Ethernet chip and NAND chip as per
Gumstix COM + TOBI/Chestnut design and these standard devices must
still work as per norm.

I've been searching via GMANE for similar questions but some are
pointing to non-existence archives.

I believe I have to develop a kernel device driver to register the
FPGA and from which will expose a device node for the test
application.
or is there a generic GPMC driver that does it?

Can someone share with me similar layout and code so that I can base
my learning from a starting point?

Many thanks in adv.

--
Regards,
James
