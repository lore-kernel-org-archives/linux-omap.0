From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Thu, 25 May 2006 14:28:17 +0300
Message-ID: <447594D1.60401@cc.jyu.fi>
References: <4457C35D.4020700@cc.jyu.fi>
	<fd1e34b0605222135x650aaac9t31437eac3b9fdb7a@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fd1e34b0605222135x650aaac9t31437eac3b9fdb7a@mail.gmail.com>
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

James

Thanks for the info, I have been quite busy but in Finland we have today
holiday so I have now time again to
prepare a new set of patches. Can you verify some issues that have
remained open.
Is it working for you without these lines in the audio_process_dma()
function. (in omap_alsa.c)

        spin_lock_irqsave(&s->dma_lock, flags);
        omap_stop_alsa_sound_dma(s);
        spin_unlock_irqrestore(&s->dma_lock, flags);

At least you added those lines once for there for testing. (I need to
use those with my omap1510 based device)

Mika

James Selvam wrote:

> Hi Mika/All,
>
> Im happy to inform you that the patches you sent have been tested and
> they are found to be working fine on my Innovator 1510. There should
> be no problem with it going into the git.
>
> I was bogged down by a hardware snag on my Innovator kit which delayed
> the verification. But I see its fine now. :-) .
>
> Thanx for the help.
>
> Regards,
> James.
>
>
> On 5/3/06, *lamikr* <lamikr@cc.jyu.fi <mailto:lamikr@cc.jyu.fi>> wrote:
>
>     Following patch set should fix the broken method references to
>     from Alsa
>     and OSS drivers to tlv320aic23 i2c drivers that has been reported.
>     In addition the 3:rd patch contains the platform driver code that the
>     innovator requires if it wants to use alsa driver.
>
>     I do not own myself the innovator or aic23 drivers so it would be nice
>     if someone else could test these.
>
>     Mika
>     _______________________________________________
>     Linux-omap-open-source mailing list
>     Linux-omap-open-source@linux.omap.com
>     <mailto:Linux-omap-open-source@linux.omap.com>
>     http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>     <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>
>
>
