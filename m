From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/4] lis3: lis3lv02d_i2c: Add device tree support
Date: Fri, 14 Sep 2012 12:51:06 -0700
Message-ID: <20120914125106.ae809500.akpm@linux-foundation.org>
References: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
	<201209141531.36734.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33595 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab2INTvH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 15:51:07 -0400
In-Reply-To: <201209141531.36734.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: AnilKumar Ch <anilkumar@ti.com>, gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

On Fri, 14 Sep 2012 15:31:36 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 14 September 2012, AnilKumar Ch wrote:
> > Adds device tree support to lis3lv02d_i2c driver. Along with this
> > DT init is moved from core driver to individual drivers, with the
> > current implementation some pdata is missing in lis3lv02d_i2c driver.
> > 
> > Also adds platform data for lis331dlh driver to am335x-EVM. These
> > patches were tested on AM335x-EVM.
> > 
> 
> No further comments on this version besides the ones I already gave
> on v1.

My linux-arm-kernel subscription died so I don't know what your v1
comments said.  Were they fatal?

