From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove duplicate definition of
 omap_test_timeout
Date: Mon, 23 Jan 2017 07:06:48 -0800
Message-ID: <20170123150648.GP7403@atomide.com>
References: <20170120185151.1630-1-tony@atomide.com>
 <130610aa-ed1a-b363-fac5-6aaaf4d8e930@ti.com>
 <97761042-4a61-9abe-8b6f-a306936cb513@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <97761042-4a61-9abe-8b6f-a306936cb513@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170123 05:45]:
> On 23/01/17 12:22, Lokesh Vutla wrote:
> > + Tero,
> > 
> > On Saturday 21 January 2017 12:21 AM, Tony Lindgren wrote:
> > > We have the same defined already in common.h.
> > 
> > 
> > This is reverting what has been introduced in this[1] series. Probably
> > Tero can comment more here.
> 
> Yeah, the point of introducing that was to get rid of common.h include from
> the prcm files. See commit 250e27ee950bf67ceeb812eb4c8f2fea58d3e2b6.

OK let's forget it for now then.

Regards,

Tony
