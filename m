From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MENELAUS: Remove unnecessary pr_err definition
Date: Mon, 13 Aug 2007 01:50:07 -0700
Message-ID: <20070813085005.GF13948@atomide.com>
References: <20070810100130.GQ8658@atomide.com>
	<11867473111943-git-send-email-felipe.lima@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11867473111943-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.lima@indt.org.br> [070810 05:02]:
> Instead of defining a pr_err() macro, we can use dev_err() macro.

Pushing today.

Tony
