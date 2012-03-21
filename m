From: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/3] Documentation: common clk API
Date: Wed, 21 Mar 2012 09:23:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1203210855510.24151@xanadu.home>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
	<CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
	<201203161218.05125.arnd.bergmann@linaro.org>
	<201203162057.58706.arnd@arndb.de>
	<alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
	<20120316234706.GJ3852@pengutronix.de>
	<alpine.DEB.2.00.1203201611330.22974@utopia.booyaka.com>
	<alpine.LFD.2.02.1203202233340.24151@xanadu.home>
	<alpine.DEB.2.00.1203210018260.30543@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1203210018260.30543-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Saravana Kannan <skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Kerr <jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 21 Mar 2012, Paul Walmsley wrote:

> Hello Nico,
> 
> On Tue, 20 Mar 2012, Nicolas Pitre wrote:
> 
> > This common clk API has been under development for over *two* years 
> > already, with several attempts to merge it.  And each previous merge 
> > attempt aborted because someone came along at the last minute to do 
> > exactly what you are doing i.e. underline all the flaws and call for a 
> > redesign.  This is becoming a bad joke.
> 
> There is a misunderstanding.  I am not calling for a redesign.  I am 
> simply stating that the current maturity level of the API and code should 
> be documented in the Kconfig dependencies or description text before the 
> code goes upstream.  The objectives are to make future changes easier, set 
> expectations, and clearly disclose the extent to which the API and code 
> will need to change.

Maybe there is no actual consensus on that extent.

> > The code will be easier to change once it is in mainline, simply due to 
> > the fact that you can also change all its users at once.  And it is well 
> > possible that most users won't have to deal with the same magnitude of 
> > complexity as yours, again reducing the scope for resistance to changes.
> 
> I hope you are right.  To me, these conclusions seem unlikely.  It seems 
> equally likely that these rationales will make it much more difficult to 
> change the code once it's upstream and platforms are depending on it.  

No code should go upstream if no one depends on it.  Therefore we change 
code that many platforms depend on all the time.  What is killing us is 
the need to synchronize with multiple external code bases scattered 
around.

> Particularly given the ongoing sensitivity to reducing "churn" of mainline 
> code, so publicly discussed.

Please stop buying into that crap.  We congratulate ourselves every 
merge cycles with the current process being able to deal with around 
half a million of lines changed every 3 months or so.  It's pointless 
churn that is frowned upon, not useful and incremental API changes.  I 
don't think that "pointless" would apply here.

> So it seems like a good idea to attempt to address these potential 
> roadblocks and criticisms to major clock framework changes early.

I understand your concern, however I don't think it is as serious as you 
are making it.

> One last comment to address which is orthogonal to the technical content 
> of this discussion.
> 
> > Otherwise one might ask where were you during those development years if 
> > you claim that the behavior and/or API of the common clock code still 
> > need to change significantly?
> 
> One might ask this.  If one were to ask this, another might briefly 
> outline the participation in public and private clock discussions at 
> Linaro Connect in Budapest and Redwood Shores, at LPC in Santa Rosa, at 
> ELCE/KS in Prague, at ELC in Redwood Shores, in conference calls, IRC 
> sessions, and private E-mails with many of the people included in the 
> header of this message, not to mention the list posts.

Sure.  I was there too and came across you many times.  I just don't 
understand why some apparent consensus was built around the current 
submission, that people involved appeared to be highly satisfied at 
last, given the emphasis you are giving to your present concern which 
doesn't seem to be widely shared.  This is a bit surprising.

> None of the concerns that have been described are new.  There has been an 
> endeavour to discuss them with anyone who seemed even remotely interested.

Let's change tactics then.  We've been discussing this code for over two 
years and no one could really benefit from it during that time.  Maybe 
future discussion could become more productive and concrete when some 
code is merged _and_ used at last.


Nicolas
