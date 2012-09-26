From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/4] lis3: lis3lv02d_i2c: Add device tree support
Date: Wed, 26 Sep 2012 13:34:50 -0700
Message-ID: <20120926133450.8beeed6e.akpm@linux-foundation.org>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
	<20120926202400.GA27830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56142 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab2IZUev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 16:34:51 -0400
In-Reply-To: <20120926202400.GA27830@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: AnilKumar Ch <anilkumar@ti.com>, arnd@arndb.de, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

On Wed, 26 Sep 2012 13:24:00 -0700
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Sep 17, 2012 at 12:53:18PM +0530, AnilKumar Ch wrote:
> > Adds device tree support to lis3lv02d_i2c driver. Along with this
> > DT init is moved from core driver to individual drivers, with the
> > current implementation some pdata is missing in lis3lv02d_i2c driver.
> > 
> > Also adds platform data for lis331dlh driver to am335x-EVM. These
> > patches were tested on AM335x-EVM.
> 
> None of these patches apply to any tree that I know of, what did you do
> them against?  Please redo them against the char-next branch of
> linux-next and resend them if you wish to see them applied.

Presumably they're against eariler patches whcih you don't have.  I'm
presently sitting on

drivers-misc-lis3lv02d-add-generic-dt-matching-code.patch
drivers-misc-lis3lv02d-add-generic-dt-matching-code-fix.patch
drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code.patch
drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code-fix.patch
drivers-misc-lis3lv02d-lis3lv02d_spic-add-dt-matching-table-passthru-code-fix-fix.patch
drivers-misc-lis3lv02d-remove-lis3lv02d-driver-dt-init.patch
drivers-misc-lis3lv02d-lis3lv02d_spic-add-lis3lv02d-device-tree-init.patch
drivers-misc-lis3lv02d-lis3lv02d_spic-add-lis3lv02d-device-tree-init-fix.patch
drivers-misc-lis3lv02d-lis3lv02d_i2cc-add-lis3lv02d-device-tree-init.patch
drivers-misc-lis3lv02d-lis3lv02d_i2cc-add-lis3lv02d-device-tree-init-fix.patch
drivers-misc-lis3lv02d-fix-some-comments-specific-to-lis331dlh-driver.patch

