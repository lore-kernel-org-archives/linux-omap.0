From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
Date: Mon, 5 Nov 2012 04:40:00 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC002B4@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
 <509544A8.7010507@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34983 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab2KEEkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Nov 2012 23:40:15 -0500
In-Reply-To: <509544A8.7010507@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Kevin,

On Sat, Nov 03, 2012 at 21:52:00, Kevin Hilman wrote:
> On 11/02/2012 12:32 PM, Vaibhav Bedia wrote:
> > AM33XX has only one usable timer in the WKUP domain.
> 
> After reading the TRM, it seems there are two: DMTIMER0 and DMTIMER1.
> 
> Looking at the hwmod data though, I don't see a hwmod for DMTIMER0.  Can
> you explain a little about why DMTIMER0 is missing/broken?
> 

DMTimer0 is usable only in secure devices only. This timer by default runs
from an inaccurate RC oscillator the frequency of which can be anywhere
from 16-60KHz based on process variations. There is a mux to change the
clock source but the register for the mux can't be modified in GP devices.
(will add this in the changelog)

Regards,
Vaibhav
