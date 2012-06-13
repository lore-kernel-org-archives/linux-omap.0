From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 04/12] ARM: OMAP4: hwmod data: fix 32k sync timer idle
 modes
Date: Wed, 13 Jun 2012 11:22:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206131121580.30212@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004602.20034.73590.stgit@dusk> <4FD5BAE7.7080805@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40635 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2FMRWP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 13:22:15 -0400
In-Reply-To: <4FD5BAE7.7080805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> > The 32k sync timer IP block target idle modes are incorrect in the
> > hwmod data are incorrect.
> 
> Nit: Is there too many "incorrect" in this sentence?

Thanks; patch updated.


- Paul
