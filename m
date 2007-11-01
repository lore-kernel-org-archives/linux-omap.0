From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Update PRCM rate-table entries for 2430
Date: Thu, 1 Nov 2007 02:17:14 -0700
Message-ID: <20071101091713.GE780@atomide.com>
References: <20071030113449.099074338@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025C0596@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429025C0596@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [071030 12:52]:
> > On Behalf Of Kevin Hilman
> > Sent: Tuesday, October 30, 2007 6:35 AM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: [PATCH] ARM: OMAP: Update PRCM rate-table entries for 2430
> > 
> > [resend with minor build fix and updated description]
> > 
> > Follow the lead of the TI kernels by removing PRCM #2 and adding PRCM
> > #3 and #4 to the rate-table entries.  According to TI, having #2 and
> > #3 together is known to be a bad combination.
> > 
> > Also, change the default divider values for the PRCM #5a setting to
> > match those of the TI kernel.  Using the smallest divider possible can
> > give significant power savings when using the data-driven idle modes.
> > 
> > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Using the lowest N value gives the best power savings.  It might be we need to think a bit on how better to sort table rates.  The MPU index is not unique enough.  Could be per-board or something more cleaver.

Pushing this today.

Tony
