From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.21-rc5-omap1-git] OSK led fixes
Date: Tue, 3 Apr 2007 14:52:08 -0400
Message-ID: <20070403185206.GF32591@atomide.com>
References: <200704021248.10783.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200704021248.10783.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070402 16:47]:
> Bugfixes for the OSK led support:
> 
>  - Fix Kconfig merge glitches:  Mistral handles idle and timer leds just fine
>  - Fix pm_suspend() runtime botch:  can't sleep, so can't touch tps65010 leds 
> 
> Improvements:
>  - Switch sense of Mistral idle led, so idle == off
> 
> Probably the TPS65010 leds should be handled only by the "new led" API.

Pushing to omap-upstream.

Tony
