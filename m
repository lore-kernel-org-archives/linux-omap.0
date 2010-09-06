From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Mon, 6 Sep 2010 22:59:05 +0300
Message-ID: <20100906195904.GA2864@besouro.research.nokia.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
 <1282130412-12027-2-git-send-email-thara@ti.com>
 <87eiddgjr7.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
 <87r5ha3hlk.fsf@deeprootsystems.com>
 <20100903173046.GA32226@rakim.wolfsonmicro.main>
 <87pqwu1zcw.fsf@deeprootsystems.com>
 <20100903182052.GB32226@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25914 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab0IFUBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 16:01:48 -0400
Content-Disposition: inline
In-Reply-To: <20100903182052.GB32226@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hello,

On Fri, Sep 03, 2010 at 08:20:52PM +0200, Mark Brown wrote:
> On Fri, Sep 03, 2010 at 11:00:31AM -0700, Kevin Hilman wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > > The only thing I can think you might need to do if this is just straight
> > > voltage setting is re-add support for multiple consumers setting
> > > voltages simultaneously 
> 
> > Yeah, that sounds like what we need.
> 
> > re-add? was it there at one point and removed?  Any pointers to the old
> > code?
> 
> It was present in the pre-merge regulator API which you can find in the
> bowels of:
> 
>    git://opensource.wolfsonmicro.com/linux-2.6-audioplus
> 
> but was removed to simplify review during the merge.  It's fairly simple
> to do, it's just that there's been no demand.
> 
> Essentially all that needs doing is that when regulator_set_voltage() is
> called instead of merging with the machine constraints and applying the
> setting immediately we store the constraints that are specified in the
> consumer then iterate over all enabled consumers applying all the
> constraints that they've set in addition to those from the machine.
> This results in a configuration which is the lowest possible voltage
> which satisfies all the constraints that have been supplied and for
> supplies with only one consumer it gives the same behaviour as we have
> currently.

How about taking Thara's proposal of using priority lists?

I mean, it could make more sense to keep the constraints into a priority list,
instead of "iterate over all enabled consumers"?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

---
Eduardo Valentin
