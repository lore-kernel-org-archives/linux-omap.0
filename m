From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: gpio Interrupt handling for omap5912
Date: Mon, 14 Aug 2006 01:22:15 +0300
Message-ID: <44DFA617.3030505@cc.jyu.fi>
References: <20060804024947.80936.qmail@web55802.mail.re3.yahoo.com>
	<44DF33FB.3050003@gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <44DF33FB.3050003@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> Hi all,
>
> to avoid that things like HowTo below are lost, what do you think is
> the best place to store them?
>
> I can imagine
>
> - Documentation/arm/OMAP/GPIO
I would prefer this even it might be even too obvious place to search
this kind of docs :-) But of course OSK wiki is also good location.
Maybe there could also be something from the just added GPIO switch
framework usage and omap platforms it should support. (OMAP1, OMAP2?)

Another area from which I would be interested in would be ARMIOs, as I
have only found my self couple of references to them without good
explanation what they really are. They seems to be something that
remains GPIO's and I would be interested in to know whether GPIO
functions are supposed to handle also them by just using certain high
enought ID numbers, or should they be treated diffrerently?

Mika
