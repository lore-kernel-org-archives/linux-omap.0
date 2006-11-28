From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To enable I2C-2 for 2430 SDP
Date: Tue, 28 Nov 2006 02:23:10 +0000
Message-ID: <20061128022310.GB7763@atomide.com>
References: <456B3E4C.2060300@gmail.com>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01F7E909@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E909@DLEE09.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [061127 20:10]:
> My logic was to keep the existing implementation as is. I don't know if
> other boards were using this too (can't be). I wanted to isolate 2430
> with other OMAP2 boards (if any). If H4 is the only user, then we can
> put "machine_is_omap_h4" instead of "cpu_is_omap2430"

Yeah I guess in some cases it could be board specific config not to use
I2C. Pushing this patch as we were already doing the muxing :)

Regards,

Tony
