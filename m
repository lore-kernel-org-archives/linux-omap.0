From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 03:55:29 +0200
Message-ID: <20061116015528.GR21064@atomide.com>
References: <20061116010133.GL21064@atomide.com>
	<77C7F7CB1230A74A9D19C0C111E6EDBE01E422BA@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01E422BA@DLEE09.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [061116 03:22]:
> Tony,
> 
> Agreed, it might be early to talk on 3430. I was just giving examples of
> I2C blocks across OMAPs. 
> 
> For my work now, I will follow the existing structure. This can be
> discussed later along with 3430 code placement :)

Yeah, and we may want to add some common init function where you just
pass the port offsets or something like that.

Regards,

Tony
