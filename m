From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DRA7: hwmod: Add data for McASP3
Date: Wed, 11 Nov 2015 13:40:44 -0800
Message-ID: <20151111214043.GI3218@atomide.com>
References: <1447261631-26362-1-git-send-email-balbi@ti.com>
 <56439641.6070901@ti.com>
 <alpine.DEB.2.02.1511112022100.24530@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1511112022100.24530@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [151111 12:23]:
> On Wed, 11 Nov 2015, Peter Ujfalusi wrote:
> 
> > On 11/11/2015 07:07 PM, Felipe Balbi wrote:
> > > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > 
> > > McASP3 is used by default on DRA7x based boards for audio.
> > 
> > While this patch works, it is not the correct one(s) to apply.
> > https://lkml.org/lkml/2015/10/30/91
> > is the series which should have been applied to 4.4.
> > Paul acked the series, but for some reason it missed the initial ARM pull for 4.4
> 
> It missed it because I was late getting my patches out for 4.4...

OK applying all three as fixes with your ack like you requested
in the original thread.

Tony
