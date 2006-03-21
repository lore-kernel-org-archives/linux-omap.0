From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: ALSA with OSK
Date: Tue, 21 Mar 2006 23:40:02 +0200
Message-ID: <442072B2.5050005@cc.jyu.fi>
References: <442020C6.1060203@gmail.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <442020C6.1060203@gmail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:

> Hi,
>
> just tried ALSA on OSK with recent 2.6.16:
>
> # madplay /mnt/nfs/foo.mp3
> MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004 Robert
> Leslie e.
>           Title: Foo
>          Artist: Foo
>           Album: Various - New Project
>           Track: 1
>           Genre: Blues
> output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
> #
>
> Any quick idea? 

How about if you try to play wav with aplay? Or by applying 3 alsa
patches send to list 2 weeks ago?

Mika
