From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
Date: Wed, 11 Feb 2015 12:26:12 -0800
Message-ID: <20150211202611.GF2531@atomide.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com>
 <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com>
 <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
 <54DB93DA.8050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54DB93DA.8050308@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jgchunter@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux@arm.linux.org.uk >> Russell King" <linux@arm.linux.org.uk>, "aaro.koskinen@iki.fi >> Aaro Koskinen" <aaro.koskinen@iki.fi>, "khilman@deeprootsystems.com >> Kevin Hilman" <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, tuukka.tikkanen@linaro.org
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jgchunter@gmail.com> [150211 09:43]:
> 
> Thinking about this some more, I don't understand the dependency on the
> DM_TIMER here. For an omap1 device, regardless of whether the DM_TIMERs
> are enable or not, the device should be able to enter low power if the
> 32K is enabled. Hence, shouldn't this have been !(CONFIG_OMAP_32K_TIMER)
> above?

Sounds about right, there are separate timers on omap1 and additional
gp timers. There's no 32KiHz timer on 1510 variants, including
720 and 730.
 
> Furthermore, you will get the above warning on a omap16xx only build if
> you disable DM_TIMERs and keep MPU_TIMER enabled, which should be a
> valid thing to do.
> 
> Tony, I see you added the DM_TIMER dependency in commit
> be26a008414414c69a4ae9fe9877401c3ba62c5a. I understand your motivation,
> but why not just use !(CONFIG_OMAP_32K_TIMER) here? Bit 9 of the idlect1
> is only for the TIMCK clock that is used for the MPU timers and not the
> DM_TIMERs.

Hmm yes looks like you're right. That check be done based on
!CONFIG_OMAP_32K_TIMER like you're saying.

Regards,

Tony
