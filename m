From: Kevin Hilman <khilman@mvista.com>
Subject: Re: new PRCM breakage: 2430 FB
Date: Thu, 07 Jun 2007 16:22:33 -0700
Message-ID: <46689339.5000304@mvista.com>
References: <9C23CDD79DA20A479D4615857B2E2C47011217D9@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011217D9@dlee13.ent.ti.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim wrote:
> Kevin,
> 
>> I just noticed that with the new PRCM reorg, the 2430 LCD is no longer
>> powering on.  I'll dig into it tomorrow, but any pointers would be
>> appreciated.
> 
> If you mean the LCD is not powering ON, then it's an issue with T2 LDO configuration. We use T2 LDO to enable power to 2430 UI board.
> If LCD is ON but we are not able display anything then it could be due to dss1_fclk / dss2_fclk.

Thanks for the pointer.  I haven't had a chance to dig on this yet...

FWIW, the panel doesn't seem to be powering on (no backlight, etc.)  And
during boot the dispc layer says that the reset failed:

omapfb omapfb: soft reset failed

omapfb omapfb: controller initialization failed (-19)

Kevin
