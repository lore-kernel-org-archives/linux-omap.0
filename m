From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP
 mode
Date: Sat, 6 Oct 2012 11:32:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1210061129080.16518@xanadu.home>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
 <20121006144252.GY3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121006144252.GY3874@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 6 Oct 2012, Tony Lindgren wrote:

> * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
> 
> > If so, that indicates some side effect of the safe_svcmode_maskall macro,
> > and I suspect the "movs pc, lr" bit.
> > 
> > Can you try the attached patch? It basically falls back to the previous
> > behaviour if not entered in HYP mode.
> 
> Yes, with this it boots OK.

OK. In that case, I suggest this patch be sent to Russell to fix this 
issue so he could push the ARM stuff to Linus ASAP.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
