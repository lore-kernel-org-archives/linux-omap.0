From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Sun, 31 Mar 2013 08:03:00 -0700
Message-ID: <20130331150300.GD9494@kroah.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
 <51546259.3000704@compulab.co.il>
 <51547462.3070803@ti.com>
 <5157F625.5070509@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53074 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab3CaPDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Mar 2013 11:03:03 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so835365pbc.17
        for <linux-omap@vger.kernel.org>; Sun, 31 Mar 2013 08:03:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5157F625.5070509@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

On Sun, Mar 31, 2013 at 11:39:01AM +0300, Igor Grinberg wrote:
> > Well, actually, if there was a way to add a device while somehow marking
> > it so that no driver will be bound to it... Then the user could use the
> > standard sysfs interface to bind a driver to the device. I wonder if
> > that could be done...
> 
> I don't think this can fit current platform device framework.
> But may be I'm missing something...
> May be Greg can comment on this? Greg?

I have no idea what you all are talking about, sorry.

greg k-h
