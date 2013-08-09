From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: clock: Lock PLLs in the right sequence
Date: Thu, 08 Aug 2013 22:35:34 -0700
Message-ID: <20130809053534.5348.29850@quantum>
References: <1375956851-842-1-git-send-email-rnayak@ti.com>
 <20130809011820.5348.78407@quantum>
 <alpine.DEB.2.02.1308090345340.32157@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.02.1308090345340.32157@utopia.booyaka.com>
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
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Paul Walmsley (2013-08-08 20:47:02)
> Hi Mike,
> 
> On Thu, 8 Aug 2013, Mike Turquette wrote:
> 
> > Quoting Rajendra Nayak (2013-08-08 03:14:11)
> > > On OMAP4 we have clk_set_rate()s being done for a few
> > > DPLL clock nodes, as part of the clock init code, since
> > > the bootloaders no longer locks these DPLLs.
> > ...
> > > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > 
> > Taken into clk-next. Thanks for the fix. Besides the annoying prints is
> > there a functional regression fixed by this? If so I can take into
> > clk-fixes as needed.
> 
> It's best if I take this patch upstream.  That way, potential merge 
> conflicts are avoided, since I might have other changes to 
> arch/arm/mach-omap2/cclock44xx_data.c to send upstream at the same time.

No problem. I had not yet published it to clk-next so this causes no
issue.

Regards,
Mike

> 
> 
> - Paul
