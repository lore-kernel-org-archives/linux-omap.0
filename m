From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 16:33:03 +0200
Message-ID: <1287412383.29097.1603.camel@twins>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
	<AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, Suman Anna <s-anna@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2010-10-18 at 16:28 +0200, Ohad Ben-Cohen wrote:
> On Mon, Oct 18, 2010 at 3:43 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Right, so the problem is that there simply is no way to do atomic memory
> > access from these auxiliary processing units wrt the main CPU?
> 
> Yes. There are a few relevant system-wide limitations, one of them is
> that simply the system interconnect does not support those fancy
> atomic operations.

Does it support full memory coherency though? Otherwise I can see memory
based message passing becoming rather interesting.

Without coherency everybody needs to be damn sure to flush the relevant
bits before unlocking and such.
