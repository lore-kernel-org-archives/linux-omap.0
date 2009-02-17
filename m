From: Otto Solares <solca@guug.org>
Subject: Re: kexec on Nokia Internet Tablets
Date: Tue, 17 Feb 2009 15:58:48 -0600
Message-ID: <20090217215848.GJ24800@guug.org>
References: <20090217213228.GH24800@guug.org> <20090217214612.GB11928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from guug.org ([200.9.255.30]:22451 "EHLO guug.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbZBQV6u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Feb 2009 16:58:50 -0500
Content-Disposition: inline
In-Reply-To: <20090217214612.GB11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Feb 17, 2009 at 01:46:12PM -0800, Tony Lindgren wrote:
> * Otto Solares <solca@guug.org> [090217 13:37]:
> > Hi all!
> > 
> > I want to make kexec work on current Nokia Internet Tablets but
> > maybe someone here have a clue or better if a patch :)
> 
> Do you need to patch anything for this, or does it work out of the box?

Tried with l-o out of the box and tried too with this patch applied but same
results so far:

http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-jaunty.git;a=commit;h=6cd8dd766aec17ce66aa4f732928d05534da0937

Although it seems it was reverted here:

http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-jaunty.git;a=commit;h=484b70239a16c01d706a82e5e4afe2f82f24d950

> > When I run a kexec enabled linux-omap kernel and try to boot the
> > production Maemo kernel or a linux-omap kernel I only succeed if
> > the serial-console flag in r&d mode is set, if not the device
> > just hangs.
> 
> Sounds like something does not get correctly initialized..
> 
> > It seems as a timing problem because if I insert small delays to
> > the kexeced kernel via CONFIG_BOOT_PRINTK_DELAY it works too 
> > without the serial-console flag set.
> > 
> > Any idea what to debug or where to start?
> 
> Well since the LCD is on, you could write a little function that
> writes the output to the LCD. You just need to find out the virtual
> address of the LCD and then add a function for displaying fonts..
> Pretty easy to do.

Ok, btw do you known a function name I should patch with the debugging
output?

> BTW, do you have some Maemo package for kexec?

Nope, although I host a userland patch and the statically compiled binary
here:

http://guug.org/nit/kexec/

-otto
