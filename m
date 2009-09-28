From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes, please read
Date: Tue, 29 Sep 2009 00:54:48 +0300
Message-ID: <87ske6razb.fsf@purkki.valot.fi>
References: <20090928190404.GE18957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:27304 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZI1Vyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 17:54:47 -0400
Received: by ey-out-2122.google.com with SMTP id 4so166604eyf.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Sep 2009 14:54:50 -0700 (PDT)
In-Reply-To: <20090928190404.GE18957@atomide.com> (Tony Lindgren's message of "Mon\, 28 Sep 2009 12\:04\:05 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Please note that "Remove omap extra version in Makefile"
> commit means that you now need to set the ARCH and CROSS_COMPILE
> for your compiler.

A handy tip is to create GNUmakefile containing this:

ARCH=arm
CROSS_COMPILE=arm-linux-
include Makefile

Now you can just write 'make' to compile the kernel as before.

The tip is also here:

http://elinux.org/N800#Simplify_make

-- 
Kalle Valo
