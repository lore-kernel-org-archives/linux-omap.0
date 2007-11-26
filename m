From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH] ARM: OMAP: Always enable the R/W access to all
	initiators in sram
Date: Mon, 26 Nov 2007 10:51:47 -0800
Message-ID: <20071126185146.GD21886@atomide.com>
References: <20071126020738.GA32424@party>
	<Pine.LNX.4.64.0711260348500.2694@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429028C56E5@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429028C56E5@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [071126 09:06]:
> > On Mon, 26 Nov 2007, Kyungmin Park wrote:
> > 
> > > With recent runtime constatns patches, we can't boot the board if the
> > sram is locked.
> > > I'm not sure it's the proper patch enables R/W access to all omap242x.
> > > But without this patch, it gives the following messages and abort on
> > linefecth
> > 
> > I am puzzled.
> > 
> > You have definitely found a bug.  It seems that TI, for some unknown
> > reason, moved some SCM registers, including CONTROL_STATUS, for 34xx,
> > breaking forward compatibility.  And as you point out, the offset for
> > CONTROL_STATUS in the recent patch is not right for 242x.  (It's the
> > 34xx offset.)
> 
> 24xx is not 34xx.  Among others pieces around PRCM, Security, package-configuration will be different.  Trying to hide omap3 under omap2 just makes some of these things harder to rediscover as the git tree evolves.  

Although it's more work, making things work in a general way is the best
solution in the long run.

> To make OFF mode work for targeted use cases, and match with trust zone security some register groups have been split or moved.
> 
> > I would think this would prevent 242x from booting.  Indeed, you report
> > that your setup doesn't boot.  But when I boot current git on N800 here,
> > which is 2420-based, it boots fine.  Puzzling evidence.
> 
> ** Probably your boot loader does it and his doesn't.  And/Or there are a couple other bugs around Type (emu,hs,gp,tst) and ES version.
> 
> There are real behavioral differences between GP and EMU devices and in some cases also differences between ES versions of the chip as to what mask ROM code does for you.  Firewall settings are one major part.  Boot testing on one GP device of one ES version is really not enough.
> 
> I think this kind of thing also was evident in the UART clock setting.  The u-boot we use is only turning on what is necessary where it seems the nokia one is configuring a lot more.  
> 
> * The Nokia boot loader should do as little as possible in clock and security regards else there is a danger the kernel will need a lot of rework when you try and use these features more optimally.

I agree with that. We must (re-)initialize everything in the kernel,
otherwise we'll end up with mysterious bug reports like this on things
working on some boards and failing on others.

Regards,

Tony
