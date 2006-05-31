From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Wed, 31 May 2006 03:54:11 +0300
Message-ID: <447CE933.7020207@cc.jyu.fi>
References: <4457C35D.4020700@cc.jyu.fi>	
	<fd1e34b0605222135x650aaac9t31437eac3b9fdb7a@mail.gmail.com>	
	<447594D1.60401@cc.jyu.fi>
	<fd1e34b0605260412h3d5931bcvfb629e62b61cc30b@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fd1e34b0605260412h3d5931bcvfb629e62b61cc30b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: James Selvam <james.iisc@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>
>
>     Can you verify some issues that have remained open.
>     Is it working for you without these lines in the audio_process_dma()
>     function. (in omap_alsa.c)
>
>             spin_lock_irqsave(&s->dma_lock, flags);
>             omap_stop_alsa_sound_dma(s);
>             spin_unlock_irqrestore(&s->dma_lock, flags);
>
>
> I had to add these lines to get it to work. It does not work without
> these lines. I had added these lines while testing the patches you had
> sent.
>
>     At least you added those lines once for there for testing. (I need to
>     use those with my omap1510 based device) 
>
>
> I think it is not a h6300 specific requirement (as present in the
> code) but a more generic OMAP 1510 requirement (atleast Innovator OMAP
> 1510 definitely requires it).

Thanks for the info, I will send patch immediately. Or does others have
any better idea to handle this in omap1510?

Mika
