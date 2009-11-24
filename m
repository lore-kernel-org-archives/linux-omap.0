From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
Date: Tue, 24 Nov 2009 13:20:26 +0000
Message-ID: <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
	<1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
	<20091124114836.GA10510@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091124114836.GA10510@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tero Kristo <tero.kristo@nokia.com>, Dave Estes <cestes@quicinc.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2009-11-24 at 11:48 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2009 at 12:37:03PM +0200, Tero Kristo wrote:
> > In some ARM architectures, like OMAP3, the VFP context can be lost during
> > dynamic sleep cycle. For this purpose, there is now a function
> > vfp_pm_save_context() that should be called before the VFP is assumed to
> > lose context. Next VFP trap will then restore context automatically.
> >
> > We need to have the last_VFP_context[cpu] cleared after the save in idle,
> > else the restore would fail to restore when it sees that the last_VFP_context
> > is same as the current threads vfp_state. This happens when the same
> > process/thread traps an exception post idle.
> >
> > Main work for this patch was done by Peter and Rajendra. Some cleanup and
> > optimization by Tero.
> 
> Why not re-use vfp_pm_suspend() ?  Haven't you shown that vfp_pm_suspend
> may be buggy since it doesn't save in the VFP-disabled case?

BTW, the two patches below were mentioned to me some time ago but I
haven't got the time to look at them:

[ARM] vfp: Fix bug in vfp_pm_suspend
https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=88984c9b2d69c222ee1e2afc948ca73f597d40ff

[ARM] vfp: Add additional vfp interfaces
https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=393e4bfaaf79377d29cd6bb2228f87601aeca668

-- 
Catalin
