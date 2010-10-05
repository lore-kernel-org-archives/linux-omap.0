From: Paul Walmsley <paul@pwsan.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 01:19:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050117390.13816@utopia.booyaka.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
 <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com> <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
 <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com> <4CAACFFF.9040702@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36975 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311Ab0JEHTU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 03:19:20 -0400
In-Reply-To: <4CAACFFF.9040702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pramod <pramod.gurav@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Oct 2010, Pramod wrote:

> I applied this patch on my kernel which is based on android-2.6.32 enabling
> dynamic printks. I still see the console hang after enabling the logs in
> hwmod.
> 
> I am using zoom3 board. Can you please let me know which defconfig from lo
> master branch can be used to test on zoom3? I would like to test this patch
> with lo master branch and zoom3.

Could you please paste your boot log messages here?


- Paul
