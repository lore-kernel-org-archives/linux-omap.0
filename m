From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] omapfb: panel enable/disable reordering
Date: Tue, 20 Dec 2005 14:15:00 +0200
Message-ID: <1135080900.12906.36.camel@two.research.nokia.com>
References: <20051203034219.GA1516@localhost.localdomain>
	<1133786154.7902.11.camel@localhost.localdomain>
	<20051205134905.GA21963@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051205134905.GA21963@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: imre.deak@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, 2005-12-20 at 13:56 +0200, ext Brian Swetland wrote:

> > Actually there is no requirement on calling panel->enable() before
> > omapfb_set_update_mode(), which enables the LCD DMA. It's even possible
> > to enable / disable the panel while having the LCD DMA active.
> > 
> > So lets simply switch the order of the two calls in omapfb_probe and the
> > suspend / resume functions. Please send a patch.
> 
> Sounds fine to me.
> 
> Here's such a patch.

Thanks, applied.

Cheers,
Juha
