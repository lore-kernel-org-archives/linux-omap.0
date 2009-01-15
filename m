From: Tony Lindgren <tony@atomide.com>
Subject: Please update linux-omap git link at vger (Re: Important changes,
	please read)
Date: Thu, 15 Jan 2009 11:13:16 +0200
Message-ID: <20090115091310.GW29324@atomide.com>
References: <20090114134152.GJ29324@atomide.com> <94a0d4530901140634r3ef9fd66w96d3d0f7890344b2@mail.gmail.com> <20090114150502.GN29324@atomide.com> <496E15E0.70705@canonical.com> <20090115072605.GS29324@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9crTWz/Z+Zyzu20v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53734 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZAOJNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 04:13:17 -0500
Content-Disposition: inline
In-Reply-To: <20090115072605.GS29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: postmaster@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tim Gardner <tim.gardner@canonical.com>


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Could you please change the linux-omap git link to point to
kernel.org instead of source.mvista.com as discussed in the
thread below?

* Tony Lindgren <tony@atomide.com> [090115 09:26]:
> * Tim Gardner <tim.gardner@canonical.com> [090114 18:42]:
> > Tony Lindgren wrote:
> > >>> - We stop using source.mvista.com git tree, and only use the
> > >>>  kernel.org git tree. There's no need for having two master trees,
> > >>>  and kernel.org is the standard way to go. Big thanks to
> > >>>  Monta Vista for hosting us for many years.
> > 
> > The git path at http://vger.kernel.org/vger-lists.html#linux-omap needs
> > to be changed.
> 
> Good point. Also needs to be changed at:
> 
> http://www.muru.com/linux/omap/README_OMAP_GIT

I've changed the above link.

Dave, patch against vger-lists.html is attached.

Regards,

Tony

--9crTWz/Z+Zyzu20v
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="vger-lists.html.patch"

diff -Nru a/vger-lists.html b/vger-lists.html
--- a/vger-lists.html	2009-01-15 10:59:52.076730202 +0200
+++ b/vger-lists.html	2009-01-15 11:01:24.883396113 +0200
@@ -1442,7 +1442,7 @@
 series. Send OMAP related infos, bugs or patches to this list, at least in          
 CC if they affect other subsystems. See
 
-<a href="http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary">http://source.mvista.com/git/?p=linux-omap-2.6.git;a=summary
+<a href="http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary">http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
 </a>
 for OMAP git kernel discussed on this list.
 </pre></td></tr>

--9crTWz/Z+Zyzu20v--
