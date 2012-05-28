From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: tps65910
Date: Mon, 28 May 2012 16:35:05 +0100
Message-ID: <20120528153505.GC27049@sirena.org.uk>
References: <CAP3+TErDaA9Sdf2yf9asu1kNqRowTAga6NksVW9j4c+fzi9v=Q@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98DDAD@DBDE01.ent.ti.com>
 <CAP3+TEp8mu386GNGMgQsdwy9cDysGvUthPJT1gtRMOKtD_K1Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36441 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2E1PfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 May 2012 11:35:07 -0400
Content-Disposition: inline
In-Reply-To: <CAP3+TEp8mu386GNGMgQsdwy9cDysGvUthPJT1gtRMOKtD_K1Hw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxim Podbereznyy <lisarden@gmail.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, May 18, 2012 at 07:46:26PM +0300, Maxim Podbereznyy wrote:

> Thanks a lot! This code certainly can be used as a reference. I just
> wonder why it was not possible to rewrite tps65910 driver to comply
> with current twl interface? For example tps65910 API for the

Eh?  Both devices use the standard kernel regulator API.
