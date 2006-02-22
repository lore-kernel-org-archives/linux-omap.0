From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 2/7
Date: Wed, 22 Feb 2006 10:15:07 -0800
Message-ID: <20060222181507.GC20245@atomide.com>
References: <9268368b0602210606y5a84b111g459f2b293d4ece4@mail.gmail.com>
	<520AB2AD990DC04082102F77CA1726381036EF@dlee03.ent.ti.com>
	<43FBA7E6.2080103@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43FBA7E6.2080103@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr <lamikr@cc.jyu.fi>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060222 09:26]:
> 
> >>You mean the codec files moving to sound/ ? With this board file
> >>approach this cause problems in linking the codec functions in the
> >>board file. They had to stay in the omap tree not in the sound/ .
> >>Maybe a better place to them could be plat-omap/ ?
> >>    
> >>
> >I dont see plat-omap having stuff other than omap specific code - such as dma etc.. if we put peripheral chip specific code there, i dont see kernel directory's abstraction happening properly sound/.. is the perfect place for this. The issue of linking is a minor problem - which can be handled by using proper include files.
> >Regards,
> >  
> >
> Hi,
> 
> We have put the audio codec files under /arm/arch because we have wanted
> to share the same omap-alsa.c between both codecs.
> And for that reason we need to set the function pointers to omap-alsa.c
> so that the calls from omap-alsa.c ends up to correct codec.
> 
> We have tried to do couple of different method for implementing this and
> have not sofar found any perfect solution.
> 
> In our first attempt we kept all alsa related files in sound/arm/omap
> directory.
> In addition we put get_codec_functions() method to both of the drivers
> and when the module was loaded the omap-alsa.c
> called this get_codec_functions() method. The method had one
> disadvantage, user could not build aic23 and tsc2101 drivers to same kernel
> as both of the drivers had this one function with the same name.
> 
> In our second attemt (the one included in patches) we put the board-code
> to set the function pointers. The drawback in this
> method is that the functions defined in the board-code must itself be
> linked within the board-code, otherwise we
> got linking errors in the end.
> 
> Third (non tested) alternative could work in the following way
> - Move the alsa modules probe method to codecs.
> - when probe is called, it could define the function pointers and set
> them to omap-alsa.c

We should really have all the audio related stuff in sound/arm/omap.
Only core functionality and board init should be in plat-omap and
mach-omap* directories. I could see having some dma-audio related
functions in the plat-omap, but since they are only used with audio,
they may as well be in sound/arm/omap.
 
> Fourth possibility I know would be to make own implementation from
> omap-alsa.c both for both of the codecs
> but that is something I would like to avoid.
> 
> So if you have some idea how to do this, can you give us some info how
> to do that.

Why can't you just have a common module in sound/arm/omap for the codecs,
and then the aic23 and tsc2101 drivers register their functions with it?

Regards,

Tony
