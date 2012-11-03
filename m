From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Sat, 3 Nov 2012 14:03:14 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEBAE@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50950AC7.1030707@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
 <50951F22.1070904@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32962 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab2KCODZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 10:03:25 -0400
In-Reply-To: <50951F22.1070904@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Sat, Nov 03, 2012 at 19:11:54, Kevin Hilman wrote:
[...]
> 
> Yes, please try with that.  Won't that be necessary anyways for situations
> where the powerdomain goes off?
> 

Yes, we probably got lucky with the minimal resume routine.

Regards,
Vaibhav 

