From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Mon, 20 Feb 2006 13:25:27 -0800 (PST)
Message-ID: <20060220212527.13306.qmail@web32909.mail.mud.yahoo.com>
References: <9268368b0602201316q4533a165p75a4bd0ab489681d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0602201316q4533a165p75a4bd0ab489681d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Daniel Petrini <d.pensator@gmail.com> wrote:

> 
> That is actually good news. This means that with this proposed
> modularisation, alsa can easily work in these platforms, unless the
> 2420 dma for audio be quite different.
> Regarding the #ifdefs, one can always (carefully) insert a field in
> the new omap_alsa_codec_config and pass the architecture difference
> in
> the board* files.

Yes, it is true, being careful is good, but I think it is better to
write down a thin mcbsp framework, which does expose the apis like
mcbsp.c is doing, but the as we know that same codec chip can be
connected to different mcbsps for the same OMAP chip, which can be
passed from board-* files, also which will reduce lots of #ifders of
arch selection in mcbsp.c itself. 

I think it can be derived somewhat from the existing SPI framework, but
the difference will be no real protocol drivers, and only one master
driver (as McBSP functionality remained same irrespective of OMAP1/2
series...and I hope same for DaVinci and OMAP3, and OMAP2430 is having
5 McBSPs :)). Protocol driver can be thought of as actual codec chip,
which calls the apis exposed by McBSP fwk and gets terminated at Master driver.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
