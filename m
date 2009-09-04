From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: several OMAP newbie questions
Date: Fri, 4 Sep 2009 18:08:38 -0400
Message-ID: <f96d234e0909041508m73e0f2a1r946f1c446d3880b6@mail.gmail.com>
References: <4A9CF8AC.2010408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:54071 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934350AbZIDWIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 18:08:35 -0400
Received: by pxi32 with SMTP id 32so1097803pxi.25
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2009 15:08:38 -0700 (PDT)
In-Reply-To: <4A9CF8AC.2010408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 1, 2009 at 6:34 AM, Mike Rapoport<mike@compulab.co.il> wrote:

> 3) If I'm not much mistaken, board specific pin mux configuration has to deal
> with arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c. For
> instance, if my board uses ULPI pins that have not been defined already, I need
> to patch those file with my pin mux definitions. Am I right here, or have I
> missed something?

It seems to me there should be a global mux configuration per CPU, but
should be configurable per board, group of boards, etc.  What I would
like is a set of routines can be used to configure the mux that is
then called by the board files (similar to PXA).  Especially once we
get into supporting multiple base boards with things like beagle and
overo, it would be nice to have have all this logic both places
(kernel/uboot), but maybe its needed there anyway.

Cliff
