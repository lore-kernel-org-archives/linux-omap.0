From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: [v2 PATCH 0/5] OMAP4 Power Domain Framework Support
Date: Tue, 15 Dec 2009 19:14:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC240726@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZLONoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:44:12 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This is version 2 of the patch series which adds support for OMAP4 power domain framework.

It can be applied on top of the latest Mainline Kernel.

These patches have been boot-tested on the following platforms:
-OMAP4 simulator
-OMAP4430 ES1.0 silicon
-OMAP3430 SDP

In addition to this these patches have been compile-tested for the following platforms:
-omap_2430sdp
-omap_h4_2420sdp

The complete omap4 power domain structure is auto-generated using OMAP4 hardware database and is a joint effort of Paul Walmsley (paul@pwsan.com),
Benoit Cousson (b-cousson@ti.com), Rajendra Nayak (rnayak@ti.com) and me.


Best Regards,
Abhijit Pagare


Abhijit Pagare (5):
ARM: OMAP4: PM: OMAP4 essential basic initializations.
ARM: OMAP4: PM: OMAP4 Power Domain Porting Related Clean-up.
ARM: OMAP4: PM: Add the Auto-generated OMAP4 specific power domain framework.
ARM: OMAP4: PM: Adapt the existing OMAP2/3 and common Power Domain Frameworks.
ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.

