From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] dmtimer posting
Date: Thu, 20 Mar 2008 19:01:14 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903D3B096@dlee13.ent.ti.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:53920 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYCUAEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 20:04:34 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080320115749.GF14978@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

Hi

> Attached is a rev-4 with the cpu_relax() added to while loops as
> suggested by Ladislav, and CTRL register defines moved to the right
> location.

I confirm this version of the patch works on 3430 with latest kernel.

I don't have by break out board for trace to get time stamps right now.
Next week I can get that back or I can pass a kernel off to someone else
like I was doing before.  Maybe Kevin can also make a test run on it.

If you just look the instructions trace from ETB alone, the load
function shows up here but not in the older version.  Reason for that is
the long stalls are not accounted for just the number of loops, and in
non-posted mode there is nothing to loop on, just wait.  When you hook
up ETM, it will correlate with an external time base then you get the
actual time, and its here where you see it stalled out for a long time.

Seems like its good to commit.  Maybe someone could make sure a 1710
works.

Regards,
Richard W.

