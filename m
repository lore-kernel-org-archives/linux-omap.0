From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Wed, 17 Nov 2010 08:20:20 +0100
Message-ID: <20101117082020.5903ab08@surf>
References: <20101110164414.4529cbda@surf>
	<AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
	<87pqudaxtm.fsf@deeprootsystems.com>
	<20101115115005.30b35e75@surf>
	<20101115141306.1ff68beb@surf>
	<AANLkTi=PGuYZAPO7nxko=A1PgJMMnB5Wxk86scvs1TPe@mail.gmail.com>
	<20101115151430.15c899e5@surf>
	<87pqu4c1t9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:57938 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759799Ab0KQHUa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 02:20:30 -0500
In-Reply-To: <87pqu4c1t9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Hello,

On Tue, 16 Nov 2010 14:59:30 -0800
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Hmm, using pm-core, I can hit full-chip retention in suspend on my
> Beagle C4.
> 
> However, upgrading to a recent x-loader and u-boot, I can reproduce
> the problem.

Ok, as you told me on IRC yesterday.

> The problem is an old one that seems to have resurfaced.  Namely,
> u-boot leaves the MUSB block in a state that prevents it from idling,
> and thus prevents CORE from hitting RET.
> 
> I have a series of hacks for this in the PM branch (see my
> pm-otg-reset branch) that fixes the problem, but is not clean.  This
> will work until the omap_hwmod conversion for MUSB is done.   One of
> the perks we get from omap_hwmod is that a reset is done for each
> hwmod ensuring that any (mis)configuration of the bootloader is
> cleared and the HW is in a known default state.

Ah, that's nice indeed. Are the hwmod conversion patches of musb
already available somewhere (even preliminary versions) ?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
