From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync
 timer
Date: Wed, 4 Jul 2012 08:53:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040852540.6760@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com> <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com> <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com> <87mx3f38lh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56523 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab2GDOxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 10:53:20 -0400
In-Reply-To: <87mx3f38lh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson\\, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

On Wed, 4 Jul 2012, Kevin Hilman wrote:

> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> I confirm this version is now allowing CORE to hit retention during
> suspend.

Thanks, want me to add your S-o-b also?

- Paul
