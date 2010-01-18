From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 1/2] OMAP3630: Clock: add clksel_shift to struct clk
Date: Mon, 18 Jan 2010 11:37:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181134510.3977@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com> <alpine.DEB.2.00.1001181037490.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57525 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab0ARShX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:37:23 -0500
In-Reply-To: <alpine.DEB.2.00.1001181037490.3977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Correcting myself here:

On Mon, 18 Jan 2010, Paul Walmsley wrote:

> This will chew up another (4 bytes * number of struct clks) 

Well, not really, since clksel_shift is a u8, and for the time 
being, it can nestle next to that other u8.  But:

> and it doesn't seem necessary.

It still doesn't seem necessary and so should be avoided.

- Paul
