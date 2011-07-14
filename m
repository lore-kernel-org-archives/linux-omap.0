From: Kevin Hilman <khilman@ti.com>
Subject: RE: [PATCH 1/2] TI816X: Add minimal hwmod data
Date: Thu, 14 Jul 2011 14:58:10 -0700
Message-ID: <1310680690.8322.41.camel@vence>
References: <1303922002-6946-1-git-send-email-hemantp@ti.com>
	 <alpine.DEB.2.00.1104281634050.11487@utopia.booyaka.com>
	 <5F744A5A3C131242B81CE5874BD2CFFBBF8F8F14@dlee01.ent.ti.com>
	 <alpine.DEB.2.00.1104282058370.11487@utopia.booyaka.com>
	 <2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55116 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754801Ab1GNV6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 17:58:15 -0400
Received: by mail-iy0-f175.google.com with SMTP id 10so857245iym.34
        for <linux-omap@vger.kernel.org>; Thu, 14 Jul 2011 14:58:14 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Grosen, Mark" <mgrosen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Hemant,

On Wed, 2011-07-13 at 05:07 +0530, Pedanekar, Hemant wrote:

> Any comments on the hwmod and clock patch sets?

I just discovered that other devices in this family are coming along
which will require changing the names/macros/etc. from 816x to 81xx[1].

Merging this series, followed shortly by another series that renames
everything is the type of churn we are trying to avoid.

To avoid this kind of churn, I recommend starting from the broader
family name first.

Kevin

http://arago-project.org/git/projects/?p=linux-omap3.git;a=commit;h=ce17fa2f527ed614399e577fc2fd5cd3624ee501

