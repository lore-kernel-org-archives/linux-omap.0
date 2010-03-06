From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
Date: Sat, 6 Mar 2010 20:18:49 +0000
Message-ID: <20100306201849.GD13262@n2100.arm.linux.org.uk>
References: <4B91A39F.8050502@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4B91A39F.8050502@am.sony.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
> a compiler error on kernel/trace/trace_functions_graph.c),
> although no routines were marked as __irq_entry.

Well, ARM already places the assembly exception text in its own separate
section for other reasons.  We can't place it in two sections.

What is __irq_entry used for?  Just the low level assembly or C functions?
