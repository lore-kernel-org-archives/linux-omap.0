From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] OMAP audio DMA changes for 310 CPUs
Date: Fri, 18 Aug 2006 20:07:26 +0300
Message-ID: <44E5F3CE.3010501@cc.jyu.fi>
References: <fb249edb0608180120m4d0786c7i6d4408112d7e2cf0@mail.gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608180120m4d0786c7i6d4408112d7e2cf0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi andrzej

I have couple of questions from your patch.
Your patch has couple of these changes where cpu_is_omap1510() has been
changed to cpu_is_omap15xx().
    -    if (!cpu_is_omap1510())
    +    if (!cpu_is_omap15xx())

Do they affect to the sound in omap 310? (I mean is cpu_is_omap15xx()
true for your omap310)
Or is following the only relevant omap310 specific change

    +    } else if (cpu_is_omap310())
    +        omap_start_dma(channel);

Btw, your patch will not apply on top of all 5 patches I sent.
Could you perhaps re-send it one more time? (I need also test whether
your changes could work with omap1510/h6300)

Mika

andrzej zaborowski wrote:
> Avoid restarting McBSP hardware after every DMA transfer to OMAP audio
> devices on OMAP310, restart only DMA. Also avoid trying to link DMA
> channels together as this feature isn't supported on 310 processors.
> Apply on top of "[PATCH 1/5] Change all omap15xx devices to use
> similar DMA handling than h6300 uses".
>
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   
