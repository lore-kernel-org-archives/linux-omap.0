From: Will Deacon <will.deacon@arm.com>
Subject: Re: [patch v4 3/3] arm: omap4: support pmu
Date: Sun, 15 May 2011 15:16:00 +0100
Message-ID: <1305468960.2848.2.camel@jazzbox>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
	<BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Woodruff Richard <r-woodruff2@ti.com>, linux@arm.linux.org.uk, avik.sil@linaro.org, Rabin Vincent <rabin@rab.in>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

[Adding Avik],


On Sat, 2011-05-14 at 09:48 +0100, Ming Lei wrote:
> Hi Rabin,
> 
> 2011/5/14 Rabin Vincent <rabin@rab.in>:
> > What happened to this patch?  It is neither in mainline nor in
> > linux-next.
> >
> 
> This patch depends on the two with titles:
> 
>       introduce cross trigger interface helpers
>       pmu: allow platform specific irq enable/disable handling
> 
> and the above patches have been submitted to RMK's patch system
> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
> so I can't ask omap guys to merge this one into their tree now.

I don't think that Avik's problem with this patch has been fully
addressed yet:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046899.html

So regardless of the state of -next, I think there's still some more
work to do on this code before it can go upstream.

Will
