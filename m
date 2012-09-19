From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Wed, 19 Sep 2012 20:39:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192030270.5264@utopia.booyaka.com>
References: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com> <CAP05o4+O8FXRjnXtta26rUoZpcMnpZEkdu9+J0xatCyusrjQEw@mail.gmail.com> <CAP05o4+rdtsXKV9U0MrLyu7Ce8zJ4uUEcZOJ5yfarpF42gSogA@mail.gmail.com> <20120723140830.GA8155@arwen.pp.htv.fi>
 <CAP05o4JDa5WH14SLkFswEqx6jWyr94VfxtEBsbmaiQ+5kT_abQ@mail.gmail.com> <CAP05o4+dOH6tDXU4bs5ubh8rqjpjumZjfu4zM1G6MupE0T4fhQ@mail.gmail.com> <CAP05o4LRS=svfTsNV45CcToKT7XcZ+et3+fmYzJ7xMLhidtCOA@mail.gmail.com> <20120813140928.GH14781@arwen.pp.htv.fi>
 <CAP05o4K1J_ZzUT7PtKb6ZK-DzxJogLZ+hFUv65qKE2zFFNFbGg@mail.gmail.com> <CAP05o4K5f5xUdfT2V7m+Jp9D74btPMz1bB6eYCnkBBpsZqP9tA@mail.gmail.com> <CAP05o4KaQFvOBwQoVy_-Ve=T_fwDw-SEyO8DCtfuX-r5ryiOeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57448 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab2ISUjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 16:39:41 -0400
In-Reply-To: <CAP05o4KaQFvOBwQoVy_-Ve=T_fwDw-SEyO8DCtfuX-r5ryiOeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Munegowda, Keshava" <keshava_mgowda@ti.com>, parthab@india.ti.com, linux-omap@vger.kernel.org, Linux USB Devel <linux-usb@vger.kernel.org>


Hi Samuel,

I've queued patch 1 of this series for 3.7, which should go upstream via 
the OMAP -> arm-soc path.  Also asked Keshava to re-send patch 5 to me 
once patches 2-4 have been merged.

It's up to you how to handle patches 2-4.  The series is a good step 
forward for us in terms of cleanup.  But what is probably worthwhile at 
some point is for that USB TLL "phy" code (added in patch 2) to be moved 
into some place like drivers/usb/phy, since it's not MFD-related.


- Paul
