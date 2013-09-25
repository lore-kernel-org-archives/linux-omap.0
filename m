From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Wed, 25 Sep 2013 19:24:26 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA16884@DBDE04.ent.ti.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA15ED7@DBDE04.ent.ti.com>
 <20130925134619.GG10746@radagast>
 <20130925175527.GA23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130925175527.GA23337-bU/DPfM3abD4WzifrMjOTkcViWtcw2C0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Brian,

> 
> Hi Pekon,
> 
> On Wed, Sep 25, 2013 at 08:46:19AM -0500, Felipe Balbi wrote:
> > + akpm
> >
> > On Tue, Sep 24, 2013 at 01:04:05PM -0500, Gupta, Pekon wrote:
[snip]
> > >
> > > Dear Olof and other DT Maintainers,
> > >
> > > This patch series has missed multiple merge windows, and
> > > much of the other development work on mtd/nand/omap
> > > driver is gated due to this.
> 
> Also, to be fair here: you only started CC'ing the appropriate DT
> people/list around v4, after which you got a (somewhat) prompt and
> thorough review of the DT bindings. Then several months passed before
> you addressed the reviews. So the "multiple merge windows" is not
> entirely to be blamed on others ;)
> 
> Brian

Few points I would like to clarify here, *without* pointing anyone..

(1) It was Olof's comments which directed me to cc: devicetree-discuss list.
So wrong list was always cc-ed till v4.
Refer http://permalink.gmane.org/gmane.linux.ports.arm.kernel/249662

(2) The devicetree list has been updated in MAINTAINER file towards
end of July (22/July/2013) in following commit. Whereas the patch v4
was submitted on 2/July/2013. So I wasn't aware of this new DT maillist.
commit d0fb18c5c0caf2ed0eecf3d0145450ae708ed75a
Commit:     Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CommitDate: 2013-07-22

(3) When a maintainer gives a NAK, I expect him to at-least give
directions on what to change in the patch. There were no comments
given, neither new patch reviewed by the DT maintainer even after
sending multiple request directly.
http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html
http://lists.infradead.org/pipermail/linux-mtd/2013-July/047629.html

Its only when Artem and yourself pitched in by sending a mail to
new DT mail-list that the DT maintainer reviewed and provided the
comments for fixes.
But by that time 3.11-rc6 had already gone past, and so I knew this
Series cannot go in, so I wanted to wait some more, to see if there
were any more comments on this. And frankly I was too much
frustrated by then.

Just to speak my opinion.
We all understand that maintainers are heavily loaded by tons of
emails, And reviewing each patch instantly is not possible.

But this load is now passing to developers like me as frustration,
because most of energy is being spent in re-submitting patches
again and again, without any proper direction or conclusion.
And then there is no time and energy left for good work, where
we can contribute to optimizing frame-works for performance or
adding new features.
So I see many good developers distracting away from mainline.

Thus, there should be a mechanism, where such load can be
distributed, and there are less emails. And developers don't
have to re-submit patch multiple times, by collecting most reviews
at once.  This way developer's like me can spend more time in doing
other constructive things.

Please consider this as constructive feedback, without targeting
any individual or team.


with regards, pekon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
