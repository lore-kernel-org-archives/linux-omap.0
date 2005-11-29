From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mux: simplify MUX_CFG_730 and add some usb client pins
Date: Mon, 28 Nov 2005 18:11:57 -0800
Message-ID: <20051129021156.GF8319@atomide.com>
References: <20051126051858.GA22303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051126051858.GA22303@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Brian Swetland <swetland@google.com> [051125 21:20]:
> 
> As I continue to try to sort out USB gadget support on the 730, I find
> that I need to add some pin definitions.  
> 
> Since the 730 lacks PU_PD registers, and the pullup bit is always in
> the config register on the 730, I simplified the MUX_CFG_730() macro
> a little bit (to avoid typing a bunch of 0s and NAs on *every* line).
> 
> Does this make sense?

Yes, thanks. Pushing today.

Tony
