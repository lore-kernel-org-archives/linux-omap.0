From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Update n800_defconfig
Date: Wed, 28 Nov 2007 12:44:45 -0800
Message-ID: <20071128204445.GW11825@atomide.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-4-git-send-email-lauri.leukkunen@nokia.com>
	<20071128021600.GD11825@atomide.com> <474DCD7E.8020608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <474DCD7E.8020608@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [071128 12:22]:
> ext Tony Lindgren wrote:
> > * Lauri Leukkunen <lauri.leukkunen@nokia.com> [071122 16:38]:
> >   
> >> Enable N810 and lzo support for jffs2.
> >>
> >>     
> >
> > Pushing today, I've refreshed it to apply after Carlos' MMC patches.
> >
> > Tony
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> >   
> Hi Tony,
> 
> The n800_defconfig update proposed by Lauri Leukkunen' patch [1] is reverting my committed patch [2], that enables MMC support on n800_defconfig.
> 
> Should I resent my patch?

Oops, sorry I'll reapply it. I'll also leave out the bounce buffer as
omap mmc supports scatter gather.

Tony


> [1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=d202198c6c1f78a92bae3d2e10dd6f76d19e02aa
> [2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=59c7c958830efe76e561dba8f20a9b4d5af3adfe
