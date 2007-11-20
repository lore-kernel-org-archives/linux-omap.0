From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3430 and UART3 parent clocks
Date: Tue, 20 Nov 2007 13:26:44 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711201324420.10327@utopia.booyaka.com>
References: <1194982452.7433.55.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711140221470.3713@utopia.booyaka.com>
	<1195052848.15127.30.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711151356390.32494@utopia.booyaka.com>
	<1195264997.24857.27.camel@vence.hilman.org>
	<1195587796.17706.12.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195587796.17706.12.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: amit@verdurent.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 20 Nov 2007, Kevin Hilman wrote:

> Paul,
> 
> I found the root cause of this (patch just posted.)
> 
> The PER_MOD based ICLKs were actually delcared in WKUP_MOD instead of
> PER_MOD.  The result being that the clk_enable() calls for uart3_ick
> were not actually enabling the right bit.

Hi Kevin,

that's great -- thanks for tracking that down.  

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
