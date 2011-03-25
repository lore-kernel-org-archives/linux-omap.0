From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 25 Mar 2011 12:25:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A7E21D7@dbde02.ent.ti.com>
References: <87oc5ifu12.fsf@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
 <20110311191324.GE10079@atomide.com> <87d3lx5hoo.fsf@ti.com>
 <20110314171240.GB7258@atomide.com> <8762rhtnje.fsf@ti.com>
 <20110319002719.GF18583@atomide.com>
 <b65bf7960033964fba8f03e774b46905@mail.gmail.com>
 <20110321170758.GF2811@atomide.com> <87sjuge31n.fsf@ti.com>
 <20110321191114.GH2811@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932268Ab1CYGzt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 02:55:49 -0400
In-Reply-To: <20110321191114.GH2811@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Hi Tony,
[...]
> Well the dmtimer code can then become just a regular platform_device
> based driver, except for clockevent and clocksource on omap2 & 3.
Should I re-post the patch series with removal of duplicate initialization
Which Kevin pointed out + other relevant comments?
Or, wait for your patch series!
--
Tarun
[...]
