From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: init (busybox) problem on OSK5912
Date: Thu, 4 May 2006 17:10:47 -0700 (PDT)
Message-ID: <20060505001047.52257.qmail@web52309.mail.yahoo.com>
References: <fb249edb0605040943k8a85615w76b5231436d5aec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0605040943k8a85615w76b5231436d5aec@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Andrzej,

   Thanks for your response. However, we already have
swap support enabled all the time, but still the
problem persists. And it does not seem random at all,
our applications always fail with a segfault when
connecting or binding to a socket....

   I'm using the tool chain available at the
linux.omap website (3.3.2).... I've tried 3.4.1 but I
still have the same problem... do you have a link to
the newest toolchain (binaries please). It might be
worth a try... 

   Thank you very much!

- Ed -



--- andrzej zaborowski <balrog@zabor.org> wrote:

> Hi Eduardo,
> 
> From your description it sounds like a similar bug
> to what we've been
> facing on some PDAs based on OMAP311. If it is the
> same thing, then it
> doesn't matter what version of busybox or other
> applications you are
> running or whether it's compiled statically. All
> programs seem to be
> affected by the bug in the way that they hang or
> segfault in random
> places. Statically compiled programs do that with
> lower probability
> but they still do. Some versions are more affected
> and others less,
> but changing a single line in the busybox code
> changes that
> probability randomly.
> 
> We haven't found a definitive solution yet but we
> found a nasty
> workaround (credits go to nasty Marex): compile the
> kernel with swap
> support ("Paging of anonymous memory" in the config,
> I think) -- you
> don't need to add swap partitions, just compile the
> kernel with this
> option enabled. This should lower the probability of
> breakage to near
> acceptable level. It would be interesting to see if
> this works for you
> and if it's really the same problem. So far I was
> only seeing it on
> OMAP311. It might just as well be something totally
> different, in this
> case just ignore me.
> 
> With this option enabled we're able to run whole
> dynamically-linked
> Linux distributions including X, Gnome, KDE, gdb and
> strace. The
> problem persists but is a whole order of magnitude
> less annoying.
> 
> BTW: programs compilled statically against uclibc
> are not huge at all,
> sometime smaller than dynamically-linked against
> glibc.
> >
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam
> protection around
> > http://mail.yahoo.com
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> >
>
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> Good luck!
> 
> Regards,
> Andrzej
> --
> balrog 2oo6
> 
> Dear Outlook users: Please remove me from your
> address books
>
http://www.newsforge.com/article.pl?sid=03/08/21/143258
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
