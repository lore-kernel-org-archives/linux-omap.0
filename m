From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Wed, 24 Nov 2010 09:51:10 +0000
Message-ID: <20101124095109.GA5139@opensource.wolfsonmicro.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
 <1282130412-12027-2-git-send-email-thara@ti.com>
 <87eiddgjr7.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
 <87r5ha3hlk.fsf@deeprootsystems.com>
 <20100903173046.GA32226@rakim.wolfsonmicro.main>
 <87pqwu1zcw.fsf@deeprootsystems.com>
 <20100903182052.GB32226@rakim.wolfsonmicro.main>
 <20101124104544.13da3cd2@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39356 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752317Ab0KXJvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 04:51:03 -0500
Content-Disposition: inline
In-Reply-To: <20101124104544.13da3cd2@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Nov 24, 2010 at 10:45:44AM +0100, Thomas Petazzoni wrote:

> I went ahead and implemented this (without looking at previous existing
> code since I couldn't find it). What about the following patch ?

That's pretty much exactly what the old code did - told you it was
trivial :)
