From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Fri, 19 Feb 2010 09:27:01 +0000
Message-ID: <20100219092701.GA12138@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
 <20100218094814.GD3315@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1172@dbde02.ent.ti.com>
 <20100218104032.GA3542@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B11D9@dbde02.ent.ti.com>
 <20100218114237.GE3542@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B13F5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50027 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752108Ab0BSJ1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Feb 2010 04:27:06 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03215B13F5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, "Kakela, Pekka" <p-kakela@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Feb 19, 2010 at 12:09:57PM +0530, Nayak, Rajendra wrote:

> So I was thinking of removing all the twl6030 tables and just use
> the formula to get the selector and make sure they fall in the
> allowed range (1.0v to 3.3v).
> If that sounds good then I can post a patch for this.

Yes, that sounds good to me.
