From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmtimer posting
Date: Mon, 31 Mar 2008 13:49:04 +0300
Message-ID: <20080331104904.GK26502@atomide.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52692 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYCaKtO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 06:49:14 -0400
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [080321 02:01]:
> Hi
> 
> > Attached is a rev-4 with the cpu_relax() added to while loops as
> > suggested by Ladislav, and CTRL register defines moved to the right
> > location.
> 
> I confirm this version of the patch works on 3430 with latest kernel.

I'll push the rev-4 version of the patch today. The second patch needs
a bit more work still.

Tony


> I don't have by break out board for trace to get time stamps right now.
> Next week I can get that back or I can pass a kernel off to someone else
> like I was doing before.  Maybe Kevin can also make a test run on it.
> 
> If you just look the instructions trace from ETB alone, the load
> function shows up here but not in the older version.  Reason for that is
> the long stalls are not accounted for just the number of loops, and in
> non-posted mode there is nothing to loop on, just wait.  When you hook
> up ETM, it will correlate with an external time base then you get the
> actual time, and its here where you see it stalled out for a long time.
> 
> Seems like its good to commit.  Maybe someone could make sure a 1710
> works.
> 
> Regards,
> Richard W.
> 
