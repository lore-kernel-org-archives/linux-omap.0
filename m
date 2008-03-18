From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: OMAP MMC multiport support
Date: Tue, 18 Mar 2008 19:27:00 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B2202@dbde01.ent.ti.com>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com> <20080318115247.GE7843@atomide.com> <7EAD1AEEA7621C45899FE99123E124A0017B21ED@dbde01.ent.ti.com> <20080318134637.GA24660@ubuntu-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60715 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbYCRN5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 09:57:48 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080318134637.GA24660@ubuntu-workstation>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Seth Forshee <seth.forshee@gmail.com>, Remith Ravi <remithmailinglist@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Seth Forshee [mailto:seth.forshee@gmail.com]
> Sent: Tuesday, March 18, 2008 7:17 PM
> To: Syed Mohammed, Khasim; Remith Ravi
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: OMAP MMC multiport support
> 
> The current code needs a little bit of updating to support the second
> MMC controller on the 2430.  Below is a rough patch with the changes
> that get it working for me (on a custom board), but it is not based
> off of the git repo so it's not likely to apply directly.  Hopefully
> it will be helpful as a reference though.
> 
> Cheers,
> Seth
> 
Seth, 

This looks ok to me, can you please do some cleanups and submit this patch to Tony for getting it onto tree?

Thanks for the patch.

Regards,
Khasim
