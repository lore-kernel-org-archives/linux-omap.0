From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Fri, 3 Nov 2006 14:00:28 -0800
Message-ID: <200611031400.29261.david-b@pacbell.net>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01C6AEA2@DLEE09.ent.ti.com>
	<454B986C.6070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <454B986C.6070301@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 03 November 2006 11:28 am, Dirk Behme wrote:

> Any chance (even if I don't see it at the moment ;) ) to 
> integrate IRQF_TRIGGER_LOW instead into the existing 
> SMC_IRQ_FLAGS using machine_is_omap_2430sdp and avoiding the 
> additional #ifdef?

For that matter, why isn't H4 using TRIGGER_LOW?  The only
reason to use edge triggering on earlier hardware was that
the GPIOs didn't support level triggers.  The SMC chip is
actually level-triggered.

- Dave
