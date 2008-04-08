From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: source.mvista links are broken
Date: Tue, 8 Apr 2008 10:07:40 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08805C303DA@dbde01.ent.ti.com>
References: <5D8B5EC1EB6ED845B1EB216F00C71B65032A8F0F@dlee12.ent.ti.com><20080404110314.GN3505@atomide.com> <87myo9a3kf.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbYDHEil convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 00:38:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <87myo9a3kf.fsf@paris.hilman.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi all, 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, April 04, 2008 11:46 PM
> To: Tony Lindgren
> Cc: Iqbal; linux-omap@vger.kernel.org
> Subject: Re: source.mvista links are broken
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Iqbal <iqbal@ti.com> [080404 13:07]:
> >> 
> >> Looks like the OMAP tree links are broken and the summary,short log and other fields don't work.
> >> 
> >> 
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commit;h=8a88c221c88399bc694c367dbea01ffc4153ef20
> >
> > Yeah, I've noticed that too. Probably git needs updating on
> > source.mvista.com, it seems to have issues with reading packed objects.
> >
> > I've fixed it to some extent by scp'ing over some object files, and then
> > there was a brief file permissions problem too...
> >
> > In any case, please use the kernel.org instead:
> >
> > http://git.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >
> > I've notified Kevin about the issue, so we probably have to wait for
> > git to get updated.
> 
> git on source.mvista.com is now updated to 1.5.4.5.  Let me know if
> there are any more problems.
> 
> Kevin


I'm still unable to clone the git tree from the mvista site.

I use "git clone http://source.mvista.com/gittrees/linux-omap-2.6.git"

I can't use the git://* URLs either. I'm behind a proxy and exporting
http_proxy isn't helping.

At least, I'm able to browse the tree from the mvista server and get
file changelogs, etc from there.

Regards,
Anand
