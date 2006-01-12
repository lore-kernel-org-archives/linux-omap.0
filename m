From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Replace clk_use/unuse with clk_enable/disable,
	please test
Date: Thu, 12 Jan 2006 14:54:12 -0800
Message-ID: <20060112225412.GL5461@atomide.com>
References: <20060105232047.GD4741@atomide.com>
	<20060106130854.23627.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060106130854.23627.qmail@web32913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060106 05:08]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > Hi all,
> > 
> > Following patch removes clk_use/unuse for omap, and replaces them
> > with
> > clk_enable/disable.
> > 
> 
> I have just built the kernel for h4 with this patch and boots fine.

I've just pushed this patch.

Tony
