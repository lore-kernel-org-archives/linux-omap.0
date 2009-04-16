From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: ehci problem on OMAP35xx
Date: Thu, 16 Apr 2009 19:11:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702EAA6AC27@dbde02.ent.ti.com>
References: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E739404280467EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbZDPNlg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 09:41:36 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404280467EF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>


>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of twebb
>> Sent: Wednesday, April 15, 2009 9:35 PM
>> To: linux-omap@vger.kernel.org Mailing List
>> Subject: ehci problem on OMAP35xx
>>
>> I'm having issues getting USB up and going on HSUSB2/EHCI on
>> OMAP35xx-based hardware (very similar to beagle board).  We're using
>> an SMSC3317 connected to HSUSB2, and in turn, the 3317 is connected to

Does SMSC3317 support Input clocking mode for the 60Mhz ULPI clk?

>> an onboard hub - a SMSC USB2513.  When the hub is removed from reset,
>> it appears that handshaking/chirping starts to happen between xcvr and
>> hub, but ends with the code announcing that it is "unable to enumerate
>> USB device on port 2".  I'm guessing it's failing because we never see
>> PED set in the PORTSC_1 reg (and we are seeing PO=1 which doesn't make
>> any sense).
