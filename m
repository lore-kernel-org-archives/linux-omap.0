From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP4: clock data fixes for early 3.8-rc
Date: Fri, 14 Dec 2012 10:34:57 -0800
Message-ID: <20121214183457.GD4989@atomide.com>
References: <20121214072028.24383.41000.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:33692 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756683Ab2LNSfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 13:35:00 -0500
Content-Disposition: inline
In-Reply-To: <20121214072028.24383.41000.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121213 23:37]:
> A few bugs in the OMAP4 common clock framework data caused boot-time
> warnings on OMAP4460 PandaBoard-ES; these patches fix those.  They
> apply after the arm-soc merge during pre-3.8-rc1.
> 
> Also needed are Jon Hunter's clock fixes series; the pull request will
> combine his patches and this series.

OK good to hear, I was wondering about that patch. No need for me to
reply to that thread then :)

Regards,

Tony
