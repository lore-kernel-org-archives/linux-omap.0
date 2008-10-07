From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: HTTP url not working
Date: Tue, 7 Oct 2008 15:58:08 +0300
Message-ID: <94a0d4530810070558l7c9a4b85tc4065fb727d804bf@mail.gmail.com>
References: <94a0d4530810060744m111dfd19mf4c3a9e76f11894f@mail.gmail.com>
	 <20081007070241.GB21037@atomide.com>
	 <20081007072752.GC21037@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:51922 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbYJGM6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 08:58:09 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3553269rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Oct 2008 05:58:09 -0700 (PDT)
In-Reply-To: <20081007072752.GC21037@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Oct 7, 2008 at 10:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [081007 09:59]:
>> * Felipe Contreras <felipe.contreras@gmail.com> [081006 17:44]:
>> > Hi,
>> >
>> > The http url doesn't seem to be working anymore:
>> > http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>> >
>> > Can you?
>> > mv .git/post-update{.sample,}
>>
>> Hmm, I just did a git-clone over http, and it worked fine.
>>
>> Kevin just told me that the new pm branched don't show up over http,
>> but do appear over git. Trying to debug.
>
> Looks like it's some kernel.org mirroring issue with http.
>
> If I edit .git/config to use git protocol:
>
> url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
> And then pull:
>
> $ rm .git/refs/remotes/origin/pm-*; git-pull -v
> From git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
>  = [up to date]      linus      -> origin/linus
>  a58e707..62c36fd  master     -> origin/master
>  = [up to date]      omap2-upstream -> origin/omap2-upstream
>  = [up to date]      omap3-upstream -> origin/omap3-upstream
>  * [new branch]      pm-0       -> origin/pm-0
>  * [new branch]      pm-0.5     -> origin/pm-0.5
>  * [new branch]      pm-1       -> origin/pm-1
>  * [new branch]      pm-20081006 -> origin/pm-20081006
> Already up-to-date.
>
> It work fine.
>
>
> But if I edit .git/config to use http protocol:
>
> url = http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
> And then pull:
>
> $ rm .git/refs/remotes/origin/pm-*; git-pull -v
> From http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
>  = [up to date]      linus      -> origin/linus
>  + 62c36fd...a58e707 master     -> origin/master  (forced update)
>  * [new branch]      pm-0       -> origin/pm-0
>  * [new branch]      pm-1       -> origin/pm-1
> Already up-to-date.
>
> It pulls something that's old.

Yes, it seems there was a git version update or something because the
post-update hook is not there anymore.

You can see it here:
http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git/info/refs

The refs are pointing to old commits, and nothing will change until
you run git update-server-info. If you enable the hook that will be
done automatically each time the refs are updated.

-- 
Felipe Contreras
