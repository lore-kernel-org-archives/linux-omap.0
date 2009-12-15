From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: [v2 PATCH 0/5] OMAP4 Clock Domain Framework Support
Date: Tue, 15 Dec 2009 19:21:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC240732@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53887 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZLONwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:52:01 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This is version two of the patch series which adds support for OMAP4 clock domain framework. 

It can be applied on top of the latest Mainline Kernel but has a dependency on the series of OMAP4 power domain framework patches sent by me earlier.

http://marc.info/?l=linux-omap&m=126088465431181&w=2


It also has a dependency on the following fix patch:

http://marc.info/?l=linux-omap&m=126088389030110&w=2


These patches have been boot-tested on the following platforms:
-OMAP4 simulator
-OMAP4430 ES1.0 silicon
-OMAP3430 SDP

In addition to this these patches have been compile-tested for the following platforms:
-omap_2430sdp
-omap_h4_2420sdp

The complete omap4 clock domain structure is auto-generated using OMAP4 hardware database and is a joint effort of Paul Walmsley (paul@pwsan.com),
Benoit Cousson (b-cousson@ti.com), Rajendra Nayak (rnayak@ti.com) and me.


Best Regards,
Abhijit Pagare

Abhijit Pagare (5):
ARM: OMAP4: PM: Make OMAP3 Clock-domain framework compatible for OMAP4.
ARM: OMAP4: PM: Modify Clock-domain interfaces for OMAP4 compatibility.
ARM: OMAP4: PM: Add the Auto-generated OMAP4 specific clock domain framework.
ARM: OMAP4: PM: Adapt the existing OMAP2/3 Clock Domain Frameworks.
ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.

