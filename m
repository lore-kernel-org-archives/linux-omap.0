From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Thu, 12 Jul 2012 10:50:13 -0700
Message-ID: <87394wg97u.fsf@ti.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com> (Paul
 Walmsley's message of "Thu, 12 Jul 2012 04:54:49 -0600 (MDT)")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joe Woodward <jw@terrafix.co.uk>
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
> 'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a 
> clockdomain to be registered twice on OMAP3 boards.  This causes warnings 
> on boot, wild pointer dereferences, and PM regressions.  Fix the double 
> registration and add some clockdomain code to prevent this from happening 
> again.
>
> Reported-by: Joe Woodward <jw@terrafix.co.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@ti.com>

This fixes the problem I reported here:

     http://marc.info/?l=linux-omap&m=134203768012711&w=2

Thanks,

Kevin
