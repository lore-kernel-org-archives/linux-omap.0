From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
	domain instance in the voltage driver.
Date: Mon, 6 Sep 2010 22:21:27 +0100
Message-ID: <20100906212127.GA21003@opensource.wolfsonmicro.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com> <1282130412-12027-2-git-send-email-thara@ti.com> <87eiddgjr7.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com> <87r5ha3hlk.fsf@deeprootsystems.com> <20100903173046.GA32226@rakim.wolfsonmicro.main> <87pqwu1zcw.fsf@deeprootsystems.com> <20100903182052.GB32226@rakim.wolfsonmicro.main> <20100906195904.GA2864@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43943 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751706Ab0IFVV3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 17:21:29 -0400
Content-Disposition: inline
In-Reply-To: <20100906195904.GA2864@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Sep 06, 2010 at 10:59:05PM +0300, Eduardo Valentin wrote:
> On Fri, Sep 03, 2010 at 08:20:52PM +0200, Mark Brown wrote:

> > Essentially all that needs doing is that when regulator_set_voltage() is
> > called instead of merging with the machine constraints and applying the
> > setting immediately we store the constraints that are specified in the
> > consumer then iterate over all enabled consumers applying all the
> > constraints that they've set in addition to those from the machine.

> How about taking Thara's proposal of using priority lists?

> I mean, it could make more sense to keep the constraints into a priority list,
> instead of "iterate over all enabled consumers"?

Partly just that the lists tend to be short enough that it's hardly
worth bothering with the more complex algorithm, partly because the fact
that you have both a minimum constraint and a maximum constraint makes
it into two priority lists you need to maintain.
