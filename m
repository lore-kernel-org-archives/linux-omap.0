From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: several OMAP newbie questions
Date: Thu, 10 Sep 2009 09:09:28 -0700
Message-ID: <87hbvaaiiv.fsf@deeprootsystems.com>
References: <4A9CF8AC.2010408@compulab.co.il>
	<f96d234e0909041508m73e0f2a1r946f1c446d3880b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:53752 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbZIJQJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 12:09:28 -0400
Received: by pzk14 with SMTP id 14so196010pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 09:09:31 -0700 (PDT)
In-Reply-To: <f96d234e0909041508m73e0f2a1r946f1c446d3880b6@mail.gmail.com> (Cliff Brake's message of "Fri\, 4 Sep 2009 18\:08\:38 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

Cliff Brake <cliff.brake@gmail.com> writes:

> On Tue, Sep 1, 2009 at 6:34 AM, Mike Rapoport<mike@compulab.co.il> wrote:
>
>> 3) If I'm not much mistaken, board specific pin mux configuration has to deal
>> with arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c. For
>> instance, if my board uses ULPI pins that have not been defined already, I need
>> to patch those file with my pin mux definitions. Am I right here, or have I
>> missed something?
>
> It seems to me there should be a global mux configuration per CPU, but
> should be configurable per board, group of boards, etc.  What I would
> like is a set of routines can be used to configure the mux that is
> then called by the board files (similar to PXA).  Especially once we
> get into supporting multiple base boards with things like beagle and
> overo, it would be nice to have have all this logic both places
> (kernel/uboot), but maybe its needed there anyway.

There is lots of agreement around the various shortcomings of the
current mux framework for OMAP.  All that's missing is someone to step
up and do the work. :/

I started a new wiki topic at elinux.org for linux-omap wishlist items:

  http://elinux.org/OMAP_wishlist

here I created a pin-mux section where we could start to keep track of
the important features needed in a new mux framework.  Adding pointers
summaries to some other platforms might be useful here as well.

This will help us get a start so when someone is ready to step up and
do the work, we'll have a starting point.

Kevin
