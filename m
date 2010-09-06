From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
	domain instance in the voltage driver.
Date: Mon, 6 Sep 2010 12:01:15 +0100
Message-ID: <20100906110115.GG8381@sirena.org.uk>
References: <1282130412-12027-1-git-send-email-thara@ti.com> <1282130412-12027-2-git-send-email-thara@ti.com> <87eiddgjr7.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com> <87r5haznq1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35615 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0IFLBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 07:01:17 -0400
Content-Disposition: inline
In-Reply-To: <87r5haznq1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>

On Fri, Sep 03, 2010 at 11:27:50AM -0700, Kevin Hilman wrote:

> In the background Thomas and I will continue to research the changes
> needed in the regulator framework.

These really are fairly straightforward, the algorithm I outlined in my
last mail will do the trick.
