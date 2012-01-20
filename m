From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3
 setup
Date: Fri, 20 Jan 2012 09:43:02 -0800
Message-ID: <20120120174302.GR22818@atomide.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
 <CANOLnONJgEJehOiH0_0AUWnAu62K-8A_cmv4UW0v=dwoQnn62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62686 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab2ATRnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 12:43:05 -0500
Content-Disposition: inline
In-Reply-To: <CANOLnONJgEJehOiH0_0AUWnAu62K-8A_cmv4UW0v=dwoQnn62w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [120120 08:51]:
> Hi Tony,
> 
> Would be nice to have this for -rc as this used to work several
> releases back when hsmmc23_before_set_reg() was checking for a
> regulator, which wasn't set for MMC3 so the function would return
> early, not causing the problem it causes now.

Yeah this looks like a fix. I'll take a look next week as I'll
be travelling.

Tony
