From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer including serial_8250.h
Date: Mon, 4 Mar 2013 20:32:50 +0000
Message-ID: <201303042032.50856.arnd@arndb.de>
References: <20130211224600.GB4801@atomide.com> <20130304190238.GU11806@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185Ab3CDUcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 15:32:55 -0500
In-Reply-To: <20130304190238.GU11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 04 March 2013, Tony Lindgren wrote:
> > Arnd & Olof, can you please apply this to your non-critical fixes
> > or some other branch that gets merged early on during the merge
> > window?
> 
> I'll apply this into omap-for-v3.9-rc1/fixes.
> 

I totally missed this one from you, and I have a couple more such
fixes for OMAP1 (and others) that I'll try to send out ASAP.

	Arnd
