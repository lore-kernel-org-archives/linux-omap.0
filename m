From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Enabling spidev in MCSPI1
Date: Wed, 13 Jan 2010 13:36:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001131329330.20437@utopia.booyaka.com>
References: <4B4DC3FB.3020702@balister.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45168 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab0AMUgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 15:36:12 -0500
In-Reply-To: <4B4DC3FB.3020702@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Philip,

On Wed, 13 Jan 2010, Philip Balister wrote:

> I'm trying to enable spidev on mcspi1, but when I do, the kernel while booting
> after the kernel is uncompressed. No useful messages are displayed. This is
> with a current git.
> 
> I've attached the diff I use to add the spi driver to the board file. (OVero +
> Summit).

Maybe try enabling early printk support if you haven't already?

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg21017.html


- Paul
