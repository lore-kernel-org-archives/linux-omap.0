From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR
 registers when MPU hits OSWR/OFF mode
Date: Wed, 25 Apr 2012 10:31:50 +0300
Message-ID: <1335339110.2149.108.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <1334914432-26456-12-git-send-email-t-kristo@ti.com>
	 <4F96E9A2.8080908@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49633 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab2DYHbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 03:31:55 -0400
In-Reply-To: <4F96E9A2.8080908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 2012-04-24 at 12:57 -0500, Jon Hunter wrote:
> Hi Tero,
> 
> On 04/20/2012 04:33 AM, Tero Kristo wrote:
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
> > overwrites the CM L3INSTR registers. So to avoid this, save them and
> > restore on the way out from MPU OSWR/OFF.
> 
> This appears to be an errata. So, it would be good to state explicitly
> here that all revisions of all omap4 devices are impacted by this
> errata. The code implies this but for documentation purposes it would be
> worth stating.

Okay, I'll add some extra beef here.

-Tero


