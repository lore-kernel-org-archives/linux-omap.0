From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Fri, 3 Sep 2010 19:20:52 +0100
Message-ID: <20100903182052.GB32226@rakim.wolfsonmicro.main>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
 <1282130412-12027-2-git-send-email-thara@ti.com>
 <87eiddgjr7.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
 <87r5ha3hlk.fsf@deeprootsystems.com>
 <20100903173046.GA32226@rakim.wolfsonmicro.main>
 <87pqwu1zcw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35265 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757189Ab0ICSU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 14:20:56 -0400
Content-Disposition: inline
In-Reply-To: <87pqwu1zcw.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Sep 03, 2010 at 11:00:31AM -0700, Kevin Hilman wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > The only thing I can think you might need to do if this is just straight
> > voltage setting is re-add support for multiple consumers setting
> > voltages simultaneously 

> Yeah, that sounds like what we need.

> re-add? was it there at one point and removed?  Any pointers to the old
> code?

It was present in the pre-merge regulator API which you can find in the
bowels of:

   git://opensource.wolfsonmicro.com/linux-2.6-audioplus

but was removed to simplify review during the merge.  It's fairly simple
to do, it's just that there's been no demand.

Essentially all that needs doing is that when regulator_set_voltage() is
called instead of merging with the machine constraints and applying the
setting immediately we store the constraints that are specified in the
consumer then iterate over all enabled consumers applying all the
constraints that they've set in addition to those from the machine.
This results in a configuration which is the lowest possible voltage
which satisfies all the constraints that have been supplied and for
supplies with only one consumer it gives the same behaviour as we have
currently.
