From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 10:17:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C30F4@dbde02.ent.ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
	<86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Sunday, June 26, 2011 4:17 AM
> To: Koen Kooi; Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org List; linux-arm-kernel
> Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> 
> On Sun, 26 Jun 2011, Premi, Sanjeev wrote:
> 
> > [sp] I didn't include a reason - because the problem may not
> >      be reproducible on the public trees.
> > 
> >      During tests performed in internal development trees, the
> >      BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
> >      range. While there was no such inconsistency on OMAP3EVM.
> 
> There are some other reasons to avoid GPTIMER12 when 
> possible, which you 
> should probably put in the patch description.  The most 
> important, in my 
> view, is that the clock source for GPTIMER12 is much less 
> frequency-stable 
> than the clock sources for GPTIMER1.  So using GPTIMER12 can 
> result in 
> major time skew over a fairly short interval.

[sp] Thanks for details. I will include in next rev.

> 
> I've been meaning to send a patch like this for some time, so 
> I'm happy to 
> see this fixed.
> 
> 
> - Paul
> 
