From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 09/12] arm: omap3: am35x: Add SDRC EMIF4 feature
Date: Wed, 11 Apr 2012 16:56:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111655440.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39264 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761375Ab2DKW4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 18:56:06 -0400
In-Reply-To: <1334171147-7517-10-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The typical SDRAM Controller Subsystem module (SDRC)
> on TI OMAP3 devices has two submodules: the SDRAM Memory
> Scheduler (SMS) submodule, and the SDRC submodule--the
> 'SDRC' acronym/term is overloaded.  The am35x family of
> devices is different in that it has an EMIF4 submodule
> instead of an SDRC submodule.  The SMS submodules are
> similar, though.

By the way, thanks for the great patch descriptions; they are very 
helpful.


- Paul
