From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 8 Nov 2012 13:05:18 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0B451@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
	<1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
	<87txt4aqyc.fsf@deeprootsystems.com>
	<B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
	<87r4o68bnl.fsf@deeprootsystems.com>
	<B5906170F1614E41A8A28DE3B8D121433EC085EE@DBDE01.ent.ti.com>
 <87pq3p72s7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab2KHNF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 08:05:27 -0500
In-Reply-To: <87pq3p72s7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Wed, Nov 07, 2012 at 22:45:20, Kevin Hilman wrote:
[...]
> >> 
> >
> > We could perhaps add a couple of APIs to check the SYSC values when coming
> > out of suspend and take appropriate action if the sysc cache does not match?
> 
> Yes, for IPs with only SW support and no drivers, we may need something
> like this.  But again, it needs to be suspend and idle aware, not just
> suspend.
> 

Ok, if the pwrmdm pre and post transition callbacks do this that should take
care of both suspend and idle.

Regards,
Vaibhav
