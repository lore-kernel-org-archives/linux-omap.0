From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Thu, 9 Nov 2006 04:23:14 +0200
Message-ID: <20061109022314.GD9740@atomide.com>
References: <200611031400.29261.david-b@pacbell.net>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01CADC92@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01CADC92@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061104 00:56]:
> Dirk / David,
> 
> Many Thanks for the review. 
> 
> Actually we can operate SMC91x in both edge and level. On H4 Ethernet
> does work with IRQF_TRIGGER_LOW, I didn't want to break any existing
> functionality on first try :). 
> 
> Dirk, thanks for pointing the comment to me, due to my screen color I
> missed it :). For now I can make both H4 and 2430SDP as
> IRQF_TRIGGER_FALLING.
> 
> But if we agree, I can configure H4 and 2430SDP for IRQF_TRIGGER_LOW.

Yeah, let's change it. Another thing that should be done for smc91x
on 24xx is to use the gpmc code for timings.

Regards,

Tony
