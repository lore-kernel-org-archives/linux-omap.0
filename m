From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fix dyntick locking patch upstream?
Date: Wed, 14 Jun 2006 18:47:56 -0700
Message-ID: <20060615014755.GL13900@atomide.com>
References: <1150308881.20600.25.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1150308881.20600.25.camel@vence.internal.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@deeprooted.net>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi

* Kevin Hilman <khilman@deeprooted.net> [060614 11:15]:
> Tony,
> 
> Is the 'fix dyntick locking' patch below planned to be sent upstream?  I
> don't see it in Linus' tree.
> 
> I'm working on testing Ingo's realtime and generic IRQ stuff on OMAP
> 2.6.17-rc6 and this is one of the diffs that causes Ingo's patch to not
> apply cleanly.

Yes, it should be applied. I'll send it to LKML.

Regards,

Tony
