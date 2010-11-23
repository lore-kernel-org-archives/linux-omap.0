From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage
 domain instance in the voltage driver.
Date: Tue, 23 Nov 2010 10:26:41 +0100
Message-ID: <20101123102641.6a45dcaa@surf>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87eiddgjr7.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AD889@dbde02.ent.ti.com>
	<87r5ha3hlk.fsf@deeprootsystems.com>
	<20100903173046.GA32226@rakim.wolfsonmicro.main>
	<87pqwu1zcw.fsf@deeprootsystems.com>
	<20100903182052.GB32226@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:32849 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0KWJ06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 04:26:58 -0500
In-Reply-To: <20100903182052.GB32226@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hello Mark,

On Fri, 3 Sep 2010 19:20:52 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > re-add? was it there at one point and removed?  Any pointers to the
> > old code?
> 
> It was present in the pre-merge regulator API which you can find in
> the bowels of:
> 
>    git://opensource.wolfsonmicro.com/linux-2.6-audioplus
> 
> but was removed to simplify review during the merge.  It's fairly
> simple to do, it's just that there's been no demand.

I'm finally taking the time to look more closely into this. I've tried
to find the original implementation of multi-consumer tracking, but
couldn't find it in the different branches of the linux-2.6-audioplus.
Do you have a more specific pointer ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
