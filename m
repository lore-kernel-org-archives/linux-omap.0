From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MMC: OMAP: Add OMAP_GPIO_SWITCH dependency for TUSB6010
Date: Tue, 9 Oct 2007 15:46:50 -0700
Message-ID: <200710091546.50813.david-b@pacbell.net>
References: <470556AB.6030201@indt.org.br> <20071009222518.GG4151@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071009222518.GG4151@atomide.com>
Content-Disposition: inline
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

On Tuesday 09 October 2007, Tony Lindgren wrote:
> This does not look right to me. Where is gpio_sw used for tusb6010?
> 
> AFAIK, it's used for bat_cover, headphone, cam_act and cam_turn.
> But not for tusb6010. Can you please check?

It's not used on the H4 ref platform, so if there's any dependency
it might be N800-specific ...
