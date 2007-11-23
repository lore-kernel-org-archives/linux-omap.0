From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Camera: Adapt to use new videobuf and
	scatterlist code
Date: Fri, 23 Nov 2007 13:39:29 -0800
Message-ID: <20071123213928.GL559@atomide.com>
References: <4746B4D4.1050605@nokia.com>
	<11958165941976-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11958165941976-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: eduardo.valentin@indt.org.br, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [071123 03:17]:
> Also take into account that videobuf_reqbufs now returns number of
> buffers when it succeeds.
> 
> (Thanks for Eduardo Valentin for initial patch.)

Pushing this and Eduardo's second patch today.

Tony
