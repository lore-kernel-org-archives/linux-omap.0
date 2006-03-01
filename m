From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 6/7
Date: Thu, 02 Mar 2006 00:09:38 +0200
Message-ID: <44061BA2.6090005@cc.jyu.fi>
References: <43FA0A3B.7070303@cc.jyu.fi>
	<520AB2AD990DC04082102F77CA1726381036ED@dlee03.ent.ti.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726381036ED@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Menon, Nishanth wrote:

>+#define CODEC_CLOCK 12000000
>
>+#define AUDIO_MCBSP OMAP_MCBSP1
>
>we should be quering the sysclk for figuring out the codec_clk. some boards such as sdp2430 have an interesting property of being able to provide 12/13mhz clk to the codec.. and hardcoding mcbsp1 wil have portability issues on omap2420 does this belong to platform structure?
>  
>
Hi Menon!

Do you know how to do that easily dynamically? It seems that the value
is often hardcoded in clock.c.
