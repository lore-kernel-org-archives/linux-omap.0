From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: lowmemory android driver not needed?
Date: Thu, 29 Jan 2009 14:29:05 +0900 (JST)
Message-ID: <20090129141238.A962.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20090129134233.A95C.KOSAKI.MOTOHIRO@jp.fujitsu.com> <20090129045916.GA24842@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756344AbZA2F3Z@vger.kernel.org>
In-Reply-To: <20090129045916.GA24842@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: kosaki.motohiro@jp.fujitsu.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Arve =?ISO-2022-JP?B?SGo/bm5ldhskQmlIGyhC?= <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha =?ISO-2022-JP?B?WXJqP2wbJEIhJhsoQiA=?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com, Trilok Soni <soni.trilok@gmail.com>
List-Id: linux-omap@vger.kernel.org

> > > > > I never expected it to be merged. I wrote it to allow us to ship a product.
> > > > > 
> > > > Then, please write "DON'T MERGE ME" on the top of patch description.
> > > > we can adjust our viewpoints.
> > > 
> > > The code will live in the drivers/staging/ directory for now and not get
> > > merged into the "main" portion of the kernel tree until everyone can
> > > agree on it.
> > > 
> > > But for now, it is useful and seems to work for a few million devices
> > > out there, so we can't just ignore it :)
> > 
> > No. 
> > if author don't hope review and merge, we don't have any reason to reviewing.
> 
> I don't think you understand the goal/model for the drivers/staging/
> subdirectories.  This is where "drivers" and other stand-alone chunks of
> code live while they are not yet up to the real mergable status for the
> rest of the kernel tree.  

I think staging is great activity, but I also think it is no good idea 
for kernel core piece.

> While there, they get cleaned up, fixed up,
> and then hopefully, merged into the main portion of the kernel tree when
> the proper subsystem maintainers say it is ok.

The fact is simple more. if auther refuse to receive reviewing,
the code don't clean up at all, don't fix up at all.
then, dropping is better.


> Whenever code in these directories is loaded, it taints the kernel with
> a TAINT_CRAP flag so that everyone involved knows to ignore any bug
> reports.
> 
> So while a review would be wonderful to have, it's not being asked for
> for this specific low-memory "driver".  I'd like to see your final
> version of what you proposed a while ago, if that goes into the kernel
> tree, then this chunk of code will merely be deleted entirely.
> 
> Hope this helps explain things better,

Again, I respect for your drivers/staging activity largely.
then, I don't oppose any driver merge to staging.

but I don't think driver/staging is good place for non driver code.
The problem is, any patch must be reviewed by stakeholder, not maintenar only.
then, the patch should post lkml and subsystem mailing list at first.

I like reviewed code than unreviewed code.
