From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/8] ARM: OMAP4: hwmod data: add HDQ/1-wire hwmod
Date: Sat, 21 Jan 2012 20:47:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201212046380.26641@utopia.booyaka.com>
References: <20120121235333.17619.56725.stgit@dusk> <20120121235934.17619.74939.stgit@dusk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55060 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab2AVDsB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 22:48:01 -0500
In-Reply-To: <20120121235934.17619.74939.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

Hi

On Sat, 21 Jan 2012, Paul Walmsley wrote:

> Add the hwmod data for the HDQ/1-wire hwmod ('hdq1w').  The scripts have 
> been updated.

just a quick note, I've dropped this patch from the series.  The HDQ 
driver does byte-width accesses, which breaks pretty badly on OMAP4.  A 
patch to fix this will be sent separately, and once that is merged, we'll 
deal with adding the OMAP4 data.


- Paul
