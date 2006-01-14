From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] McBSP support on omap24xx
Date: Sat, 14 Jan 2006 05:34:49 -0800 (PST)
Message-ID: <20060114133449.21660.qmail@web32903.mail.mud.yahoo.com>
References: <20060114012705.GR5499@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060114012705.GR5499@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:

> 
> Thanks, updated for clk_enable and manually merged the mux entries.
> Can
> you please verify?

Ooops. I should have replied to this patch earlier. It already broke
innovator1510 and 730, because of #ifdef in register defines in
mcbsp.h.

It is better to have OMAP2_ prefix for McBSP registers, as per my first
McBSP patch. I will fix this and submit the patch.

Apart from this, McBSP.c getting started looking ugly because of lots
of #ifdefers, it is better to have platform_data/driver support for
this McBSP apis _or_ a small framework.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
