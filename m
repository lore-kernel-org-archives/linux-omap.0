From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR registers
 when MPU hits OSWR/OFF mode
Date: Tue, 24 Apr 2012 12:57:54 -0500
Message-ID: <4F96E9A2.8080908@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com> <1334914432-26456-12-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55575 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab2DXR6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 13:58:00 -0400
In-Reply-To: <1334914432-26456-12-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 04/20/2012 04:33 AM, Tero Kristo wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
> overwrites the CM L3INSTR registers. So to avoid this, save them and
> restore on the way out from MPU OSWR/OFF.

This appears to be an errata. So, it would be good to state explicitly
here that all revisions of all omap4 devices are impacted by this
errata. The code implies this but for documentation purposes it would be
worth stating.

Cheers
Jon
