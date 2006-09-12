From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP audio DMA changes for 310 CPUs
Date: Tue, 12 Sep 2006 15:05:21 +0300
Message-ID: <20060912120520.GE22547@atomide.com>
References: <fb249edb0608180120m4d0786c7i6d4408112d7e2cf0@mail.gmail.com>
	<44E5F3CE.3010501@cc.jyu.fi>
	<fb249edb0609120253n41824aefub7eacde17cb5f452@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609120253n41824aefub7eacde17cb5f452@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060912 12:54]:
> On 18/08/06, lamikr <lamikr@cc.jyu.fi> wrote:
> >Hi andrzej
> >
> >I have couple of questions from your patch.
> >Your patch has couple of these changes where cpu_is_omap1510() has been
> >changed to cpu_is_omap15xx().
> >    -    if (!cpu_is_omap1510())
> >    +    if (!cpu_is_omap15xx())
> >
> >Do they affect to the sound in omap 310? (I mean is cpu_is_omap15xx()
> >true for your omap310)
> >Or is following the only relevant omap310 specific change
> >
> >    +    } else if (cpu_is_omap310())
> >    +        omap_start_dma(channel);
> >
> >Btw, your patch will not apply on top of all 5 patches I sent.
> >Could you perhaps re-send it one more time? (I need also test whether
> >your changes could work with omap1510/h6300)
> 
> Ok, this one applies on top of the five alsa patches. Sorry for the delay.

Pushing this today.

Tony
