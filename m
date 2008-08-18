From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Mon, 18 Aug 2008 12:13:05 +0300
Message-ID: <20080818091305.GA23078@kos.to>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com> <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com> <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com> <20080815.133409.81509340.Hiroshi.DOYU@nokia.com> <20080815112112.GB16840@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com> <94a0d4530808151220v75f45a09hdbca8cdf69b93b59@mail.gmail.com> <94a0d4530808151228s136e112die4718ca8ed90c22e@mail.gmail.com> <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:34705 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbYHRJNI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2008 05:13:08 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036210E46B@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>

On Fri, Aug 15, 2008 at 03:16:29PM -0500, Woodruff, Richard wrote:
> Checkpatch.pl is just a guide.  Completely changing code for the tool isn't probably a good idea. It might even get you severally flamed on LKML :)  The recent threads are informative (ok to read, bad to be in).

> Incidentally, when I asked the person working these changes, they had reported 0 functional errors had been fixed by the checkpatch changes.  A lot of the noise was typedef reduction.

I don't think completly fair complaint.

checkpatch.pl is only meant to check that patches comply to the kernel
Coding style. For a huge project such as Linux kernel, all code must
be written in uniform style. DSP bridge has probably been written
following TI's internal codingstyle documents, and as a first step
it needs to be converted to follow the Linux codingstyle.

checkpatch not a static analysing tool, which would be
neccessary for uncovering functional errors. For that we have sparse,
and mainline kernel gets regularry checked with the coverity scanner.

Focusing on checkpatch errors is a bit deceptive. It is
perfectly possible to be "checkpatch clean" yet the code
has lots of issues left. For example checkpatch cannot tell
that CSL_Strlen() can be replaced with strlen() from kernel.



-- 
"rm -rf" only sounds scary if you don't have backups
