From: Imre Deak <imre.deak@nokia.com>
Subject: Re: omapfb -- panel initialization inflexibility
Date: Mon, 05 Dec 2005 14:35:54 +0200
Message-ID: <1133786154.7902.11.camel@localhost.localdomain>
References: <20051203034219.GA1516@localhost.localdomain>
Reply-To: imre.deak@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051203034219.GA1516@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Actually there is no requirement on calling panel->enable() before
omapfb_set_update_mode(), which enables the LCD DMA. It's even possible
to enable / disable the panel while having the LCD DMA active.

So lets simply switch the order of the two calls in omapfb_probe and the
suspend / resume functions. Please send a patch.

--Imre

On Fri, 2005-12-02 at 19:42 -0800, ext Brian Swetland wrote:
> I have an lcd panel connected to a omap730 based system that *requires*
> that MCK, HSYNC, and VSYNC are active when it is powered on.  It will
> not initialize correctly otherwise.
> 
> I've modified my omapfb driver so that there is a new OMAP_LCDC_*
> flag (OMAP_LCDC_PANEL_INIT_AFTER_LCDC) that determines if the
> enable hook is called where it is in the existing driver, or if
> it is called after omapfb_set_update_mode() returns.
> 
> Any objections to this workaround?  Any suggestions for a better
> name for the flag?  Is there a better value than 0x200 for the flag?
> 
> Thanks,
> 
> Brian
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
