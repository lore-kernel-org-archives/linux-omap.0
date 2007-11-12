From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 0/3] 32k timer reorg
Date: Mon, 12 Nov 2007 12:00:16 -0800
Message-ID: <1194897616.3334.6.camel@vence.hilman.org>
References: <20071112182209.262757465@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071112182209.262757465@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2007-11-12 at 10:22 -0800, Kevin Hilman wrote: 
> Here's a short series of patches to reorganize and consolidate the 32k
> timer code.  In particular, conslidate the usage of DM timers and move
> the OMAP1 specifics into mach-omap1.

I forgot to mention that this was tested on both OMAP1 (OSK) and OMAP2
(2430SDP) in both 32k and MPU timer mode.

Kevin
