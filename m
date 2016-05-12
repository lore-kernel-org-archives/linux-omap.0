From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP5 / DRA7: Introduce workaround for 801819
Date: Thu, 12 May 2016 14:19:49 -0500
Message-ID: <5734D755.3040406@ti.com>
References: <1438876464-15424-1-git-send-email-nm@ti.com>
 <20160512171244.GT5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160512171244.GT5995@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>, Brad Griffis <bgriffis@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/12/2016 12:12 PM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [150806 08:57]:
>> Add workaround for Cortex-A15 ARM erratum 801819 which says in summary
>> that "A livelock can occur in the L2 cache arbitration that might
>> prevent a snoop from completing. Under certain conditions this can
>> cause the system to deadlock. "
> 
> Thanks for the late reminder, this has totally fallen through the
> cracks. Applying into omap-for-v4.7/fixes. Once merged to mainline,
> it can be requested for stable if needed.

Thanks for digging this out.


-- 
Regards,
Nishanth Menon
