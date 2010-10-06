From: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] omap: zoom2/3: fix build caused by wl1271 support
Date: Wed, 06 Oct 2010 22:34:40 +0300
Message-ID: <1286393680.6731.25.camel@powerslave>
References: <1285965206-17777-1-git-send-email-gadiyar@ti.com>
	 <20101001231026.GH3117@atomide.com> <1286279588.15401.28.camel@chilepepper>
	 <1286280426.15401.29.camel@chilepepper>
	 <1286284790.15401.53.camel@chilepepper>
	 <1286311187.2793.7.camel@powerslave> <20101006135221.GE2472@tuxdriver.com>
	 <AANLkTinHA+JS1MObanawFF8ktW6OEMGr7CnJhakUetPz@mail.gmail.com>
	 <1286378869.6731.7.camel@powerslave>  <20101006153025.GG2472@tuxdriver.com>
	 <1286380518.6731.10.camel@powerslave>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286380518.6731.10.camel@powerslave>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, ext Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-10-06 at 17:55 +0200, ext Luciano Coelho wrote:
> On Wed, 2010-10-06 at 17:30 +0200, ext John W. Linville wrote:
> > On Wed, Oct 06, 2010 at 06:27:49PM +0300, Luciano Coelho wrote:
> > > On Wed, 2010-10-06 at 16:01 +0200, ext Gadiyar, Anand wrote:
> > > > >> Hmmm... We got a problem here.  This patch breaks builds when we *don't*
> > > > >> have "omap: mmc extended to pass host capabilities from board file".  We
> > > > >> don't have that on wireless-next yet, so builds with zoom boards
> > > > >> selected are broken.
> > > > >>
> > > > >> Any ideas on how to solve this dilemma? I guess the proper way to handle
> > > > >> this would be to make the changes proposed in this patch when merging
> > > > >> instead of having a normal commit for it, wouldn't it?
> > > > >
> > > > > Just cherry-pick that change into the branch of your tree that I do
> > > > > _not_ pull from.  I presume that it is already available in linux-next?
> > > > >
> > > > 
> > > > Yup - both patches are in linux-next; that's where we noticed the build break.
> > > 
> > > Ok, I hope the patch applies cleanly in our trees.
> > > 
> > > John, don't you want to do the cherry-pick on your wireless-testing
> > > then? If you do it, I can "inherit" that, because I pull from it into my
> > > "testing" branch (wl12xx/master).  At the moment, w-t is broken too.
> > 
> > OK, that's fine -- do you have the commit ID and the tree that has it?
> 
> Stephen's linux-net, commit 3a63833ec3002816a759a49ebda4e229c089114e.
> 
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=3a63833ec3002816a759a49ebda4e229c089114e

I have cherry-picked it and merged it (there was a tiny conflict).  I've
pushed it into my wl12xx/master branch (wl12xx is at
git://git.kernel.org/pub/scm/linux/kernel/git/luca/wl12xx.git).

If you want to take it from my tree (which is already merged) into
wireless-testing, the commit is
adca3773ed7ad185b1314432b6fbf92db7e11bc0.


-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
