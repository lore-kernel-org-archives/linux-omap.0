From: Tony Lindgren <tony@atomide.com>
Subject: Re: source.mvista links are broken
Date: Fri, 4 Apr 2008 14:03:15 +0300
Message-ID: <20080404110314.GN3505@atomide.com>
References: <5D8B5EC1EB6ED845B1EB216F00C71B65032A8F0F@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65053 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbYDDLDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 07:03:18 -0400
Content-Disposition: inline
In-Reply-To: <5D8B5EC1EB6ED845B1EB216F00C71B65032A8F0F@dlee12.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Iqbal <iqbal@ti.com>
Cc: linux-omap@vger.kernel.org

* Iqbal <iqbal@ti.com> [080404 13:07]:
> 
> Looks like the OMAP tree links are broken and the summary,short log and other fields don't work.
> 
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commit;h=8a88c221c88399bc694c367dbea01ffc4153ef20

Yeah, I've noticed that too. Probably git needs updating on
source.mvista.com, it seems to have issues with reading packed objects.

I've fixed it to some extent by scp'ing over some object files, and then
there was a brief file permissions problem too...

In any case, please use the kernel.org instead:

http://git.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

I've notified Kevin about the issue, so we probably have to wait for
git to get updated.

Tony
