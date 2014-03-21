From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Fri, 21 Mar 2014 00:04:05 +0000
Message-ID: <1395360245.22077.43.camel@acox1-desk.ger.corp.intel.com>
References: <20140320235210.GB26964@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140320235210.GB26964@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-03-20 at 18:52 -0500, Felipe Balbi wrote:
> Hi folks,
> 
> I've been toying with the idea of removing
> drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> ungly copy of 8250 driver.
> 
> The original concern was wrt suspend/resume but I think it'd be a far
> better approach to implement runtime PM in 8250 and write a rather small
> 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> OMAP-specific details out of the way.
> 
> The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> instead of ttyS\d so removing omap-serial.c would have a direct impact
> in userland. I wonder if it's an acceptable "regression" considering
> we'd be able to reuse 8250 gaining proper Flow Control support, proper
> DMA support, years and years of bug-fixes, etc.
> 
> What do you guys say ?

I think it would be better even if we have to support calling it ttyO%d
somehow.

Alan
