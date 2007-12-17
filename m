From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC/PATCH 0/5] HDQ/1-wire support for OMAP2430/3430
Date: Mon, 17 Dec 2007 10:53:23 +0530
Message-ID: <005f01c8406c$f3409240$fe8818ac@ent.ti.com>
References: <20071216002148.GC7388@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071216002148.GC7388@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'Evgeniy Polyakov' <johnpol@2ka.mipt.ru>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Sunday, December 16, 2007 5:52 AM
> To: Madhusudhan Chikkature Rajashekar
> Cc: 'Evgeniy Polyakov'; linux-omap@vger.kernel.org; 
> linux-omap-open-source@linux.omap.com
> Subject: Re: [RFC/PATCH 0/5] HDQ/1-wire support for OMAP2430/3430
> 
> * Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com> [071210 04:02]:
> > Hi,
> > 
> > >You resolved all issues with patchet we were talking 
> about, so I only
> > >would like to see documentation update about how hdq operates in w1
> > >stack and kernel parameters you are using in the driver.
> >  Sure. I will write the necessary documentation.
> > 
> > Thanks,
> > Madhu
> > 
> > -----Original Message-----
> > From: Evgeniy Polyakov [mailto:johnpol@2ka.mipt.ru] 
> > Sent: Monday, December 10, 2007 5:04 PM
> > To: Madhusudhan Chikkature Rajashekar
> > Cc: linux-omap-open-source@linux.omap.com; 
> linux-omap@vger.kernel.org
> > Subject: Re: [RFC/PATCH 0/5] HDQ/1-wire support for OMAP2430/3430
> > 
> > Hi.
> > 
> > On Mon, Dec 10, 2007 at 03:45:25PM +0530, Madhusudhan 
> Chikkature Rajashekar (madhu.cr@ti.com) wrote:
> > > I am posting a five patches series to support HDQ/1-wire 
> module of OMAP2430 and 3430 platforms. The HDQ support is internally
> > tested
> > > using a bq27000 battery driver.
> > > 
> > > Please let me know if there are any comments on my patch set.
> > > 
> > > Evgeniy Polyakov,
> > > I would like to thank you for clearing my doubts about 
> the W1 subsystem.
> > > Please let me know if you have any further comments on my patches.
> > 
> > Ack, thanks a lot for your work.
> > 
> > You resolved all issues with patchet we were talking about, 
> so I only
> > would like to see documentation update about how hdq operates in w1
> > stack and kernel parameters you are using in the driver.
> 
> Madhu, can you please repost your complete series one more 
> time? Please
> make sure the message subject describes what the patch does instead of
> the same subject for all of them. The subject line appears in 
> the git-commit
> message, and it's a pain to re-edit each patch before applying.
Okay. I will repost the series with appropriate subject line.

> 
> Thanks,
> 
> Tony
> 
