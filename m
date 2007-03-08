From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] Move N800 specific OneNand setup to N800 platform file,
	was: Basic N800 support
Date: Thu, 8 Mar 2007 18:34:06 +0900
Message-ID: <007401c76164$f03d6dd0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070302164855.GA313@angel.research.nokia.com>
	<45EA99D0.8010103@googlemail.com>
	<20070307115754.GH21093@atomide.com>
	<004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, 'Dirk Behme' <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> > 
> > * Dirk Behme <dirk.behme@googlemail.com> [070304 02:11]:
> > > Jarkko Lavinen wrote:
> > > >>If you don't need async mode settings, it also don't need it.
> > > >
> > > >Yes. It is obvious. Removed async part. New patch attached.
> > > 
> > > Are there any dependencies to apply this patch I missed? 
> I tried to 
> > > apply it on top of  01-onenand.patch posted by Tony [1] but got 
> > > rejects.
> > > 
> > > If not, sligthly modified patch that cleanly applies on top
> > of [1] in
> > > attachment. I additionally removed duplication of
> > omap2_onenand_readw
> > > and writew. Can you please test if it is still okay? ;)
> > 
> > I've pushed Jarkko's onenand patches as two parts:
> > 
> > omap-drivers: onenand support for omap2 that can be sent to mtd list
> 
> I will push it mtd list

Umm, there's omap tree dependency.
omap2_block_sleep() & omap2_allow_sleep().

It just increase and decrease sleep_block variable atomically

Just remove it or define dummy macro?

Please give your opinions.

Thank you,
Kyungmin Park
