From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing
 preprocessor.
Date: Fri, 13 May 2011 16:04:43 +0300
Message-ID: <20110513130441.GH5323@atomide.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
 <20110513113013.GP31483@atomide.com>
 <BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
 <4DCD2260.4090806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20120 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759149Ab1EMNEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 09:04:49 -0400
Content-Disposition: inline
In-Reply-To: <4DCD2260.4090806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Cousson, Benoit <b-cousson@ti.com> [110513 15:18]:
> >>>Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
> >>
> >Unfortunately I don't have an automated tool, but that would be great
> >to have such a script. For this time I've checked the correctness of the
> >change comparing the preprocessed output.
> 
> In fact these files are already generated automatically, as written
> in the header file. So changing the output format should
> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
> manually some time ago.

Sounds like the important thing to consider here is how these macros
should be set up considering the upcoming generic clock framework
and device tree changes.

So let's wait a few days for comments from Benoit and Paul on the
format for the macros so we don't need to redo them again later.
Of course there might be other things to consider too..

Regards,

Tony
