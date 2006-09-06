From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Random Number Generation
Date: Wed, 06 Sep 2006 23:20:04 +0300
Message-ID: <44FF2D74.7000404@cc.jyu.fi>
References: <BAY102-F19F562B9CBA2B210F34131A9310@phx.gbl>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <BAY102-F19F562B9CBA2B210F34131A9310@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Abot Botbot <dejanigma@hotmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Abot Botbot wrote:
> Hello all,
>
>  I'm wondering how one would generate a random number on both the DSP
> and GPP sides. Does linux come with a tool for generating random
> numbers? Should I include a standard (and large) math.h library for
> this purpose? I know the OMAP has hardware support for the generation
> of random numbers, but I can't seem to find refferences to how to use
> it in the BSL pdf. Any insight is much appreciated.
I have not tried my self, but have you seen the random generator driver in
    drivers\char\omap-rng.c?
