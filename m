From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH 1/5] Change all omap15xx devices to use similar DMA
	handling than h6300 uses.
Date: Fri, 18 Aug 2006 09:55:29 +0200
Message-ID: <fb249edb0608180055i898cf95k8a24d6996dd1ac40@mail.gmail.com>
References: <44E5147B.3020006@cc.jyu.fi>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44E5147B.3020006@cc.jyu.fi>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 18/08/06, lamikr <lamikr@cc.jyu.fi> wrote:
> Change all omap15xx devices to use similar DMA handling than h6300 uses.

I recently got audio working on Palm Tungsten E which is OMAP311 based
(so cpu_is_omap15xx() returns 1). First I used this same fix but I was
hearing a short noise after every DMA iteration. It was fixed by
avoiding stopping and starting McBSP everytime. From reading Palm Zire
71 (OMAP310) patches by Marek Vasut, I know they had the same problem
there.
I'm going to submit a patch to apply on top of this one for audio on
OMAP310/311.

Palm Tungsten E uses a TSC2102 chip, I'm going to submit the driver
too, 2102 is slightly different from 2101.
Palm Zire 71 has a AIC23 chip.

> Thanks for the James Selvam for verifying this with omap 1510 innovator.
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007256.html
>
> Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>
>
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>

Regards,
Andrzej
-- 
balrog 2oo6
