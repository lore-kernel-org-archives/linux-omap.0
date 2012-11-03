From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 0/5] usb: musb: am335x support
Date: Sat, 3 Nov 2012 07:33:13 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com>
References: <cover.1351870620.git.afzal@ti.com>,<509420D8.1030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2KCHd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 03:33:29 -0400
In-Reply-To: <509420D8.1030307@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Daniel,

* Daniel Mack, November 03, 2012 1:06 AM:

> I'm testing these patches with an AM33xx board that has the first musb
> port wired to an USB type A plug, but it doesn't yet work for me.

> So there is no host interface registered. I'm unsure on how to fix this,
> and I didn't get an answer yet to that question when I asked Felipe
> about how interface drivers like dsps are supposed to act in order to
> get host mode back after the recent musb cleanups.

> What type of hardware do you test this with? Does host mode work for you?

To add to those details mentioned by Ravi,

This was tested on Beagle Bone with USB0 as usb-ethernet.

For purely Kernel part, this series is sufficient (along with
dependency mentioned in cover letter), considering
the fact that dt node is strictly not a part of Kernel.

To test this series, node for usbss should be present in dt.
Example in dt documentation can be pasted onto dtsi file
to get USB0 working.

Alternatively, you can fetch from,

git://gitorious.org/x0148406-public/linux-kernel.git usb

it has dt updated with usbss node.

Regards
Afzal