From: Tony Lindgren <tony@atomide.com>
Subject: Re: HTTP url not working
Date: Tue, 7 Oct 2008 19:12:49 +0300
Message-ID: <20081007161247.GC29292@atomide.com>
References: <94a0d4530810060744m111dfd19mf4c3a9e76f11894f@mail.gmail.com> <20081007070241.GB21037@atomide.com> <20081007072752.GC21037@atomide.com> <94a0d4530810070558l7c9a4b85tc4065fb727d804bf@mail.gmail.com> <20081007140046.GV21037@atomide.com> <94a0d4530810070844l422ddc35ud8e7fe7b136435d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63773 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYJGQJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 12:09:57 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530810070844l422ddc35ud8e7fe7b136435d3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

* Felipe Contreras <felipe.contreras@gmail.com> [081007 18:44]:
> On Tue, Oct 7, 2008 at 5:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Contreras <felipe.contreras@gmail.com> [081007 15:58]:
> >> On Tue, Oct 7, 2008 at 10:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> > * Tony Lindgren <tony@atomide.com> [081007 09:59]:
> >> >> * Felipe Contreras <felipe.contreras@gmail.com> [081006 17:44]:
> >> >> > Hi,
> >> >> >
> >> >> > The http url doesn't seem to be working anymore:
> >> >> > http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >> >> >
> >> >> > Can you?
> >> >> > mv .git/post-update{.sample,}
> >> >>
> >> >> Hmm, I just did a git-clone over http, and it worked fine.
> >> >>
> >> >> Kevin just told me that the new pm branched don't show up over http,
> >> >> but do appear over git. Trying to debug.
> >> >
> >> > Looks like it's some kernel.org mirroring issue with http.
> >> >
> >> > If I edit .git/config to use git protocol:
> >> >
> >> > url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >> >
> >> > And then pull:
> >> >
> >> > $ rm .git/refs/remotes/origin/pm-*; git-pull -v
> >> > From git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
> >> >  = [up to date]      linus      -> origin/linus
> >> >  a58e707..62c36fd  master     -> origin/master
> >> >  = [up to date]      omap2-upstream -> origin/omap2-upstream
> >> >  = [up to date]      omap3-upstream -> origin/omap3-upstream
> >> >  * [new branch]      pm-0       -> origin/pm-0
> >> >  * [new branch]      pm-0.5     -> origin/pm-0.5
> >> >  * [new branch]      pm-1       -> origin/pm-1
> >> >  * [new branch]      pm-20081006 -> origin/pm-20081006
> >> > Already up-to-date.
> >> >
> >> > It work fine.
> >> >
> >> >
> >> > But if I edit .git/config to use http protocol:
> >> >
> >> > url = http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> >> >
> >> > And then pull:
> >> >
> >> > $ rm .git/refs/remotes/origin/pm-*; git-pull -v
> >> > From http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
> >> >  = [up to date]      linus      -> origin/linus
> >> >  + 62c36fd...a58e707 master     -> origin/master  (forced update)
> >> >  * [new branch]      pm-0       -> origin/pm-0
> >> >  * [new branch]      pm-1       -> origin/pm-1
> >> > Already up-to-date.
> >> >
> >> > It pulls something that's old.
> >>
> >> Yes, it seems there was a git version update or something because the
> >> post-update hook is not there anymore.
> >>
> >> You can see it here:
> >> http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git/info/refs
> >>
> >> The refs are pointing to old commits, and nothing will change until
> >> you run git update-server-info. If you enable the hook that will be
> >> done automatically each time the refs are updated.
> >
> > OK, thanks for the info.
> >
> > I've renamed post-update.sample into post-update, which
> > does exec git-update-server-info.
> >
> > I've also renamed the other *.sample files to enable them.
> 
> I don't think that's a good idea... you should check what they do. I
> only know the post-update hook is needed for http.

Yeah, looks like we have them all in use in source.mvista.com.

Tony
