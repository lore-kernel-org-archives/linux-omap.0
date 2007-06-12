From: Paul Walmsley <paul@pwsan.com>
Subject: Re: new PRCM breakage: 2430 FB
Date: Mon, 11 Jun 2007 18:45:16 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0706111821110.28778@utopia.booyaka.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011217D9@dlee13.ent.ti.com>
	<46689339.5000304@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <46689339.5000304@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 7 Jun 2007, Kevin Hilman wrote:

> FWIW, the panel doesn't seem to be powering on (no backlight, etc.)  And
> during boot the dispc layer says that the reset failed:
>
> omapfb omapfb: soft reset failed
>
> omapfb omapfb: controller initialization failed (-19)

Hi Kevin,

the 'soft reset failed' message is coming from 
drivers/video/omap/dispc.c:1391.

The only PRCM-related code near that function is the display clock 
enable code, which, as Khasim mentioned, uses dss_ick, dss1_fck, and 
dss_54m_fck.  I just went back and checked the PRCM changes for those 
three clocks and omap2_clk_enable(), and they look good.

Could be a TWL4030 problem given the lack of power.

git-bisect perhaps?

Unfortunately, no 2430 SDP here, or I'd take a closer look.


- Paul
