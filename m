From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/8] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Wed, 29 Mar 2017 13:50:15 -0500
Message-ID: <cd340d7a-c0cf-9227-1382-2277ffa5b1b0@ti.com>
References: <20170329015801.22240-1-d-gerlach@ti.com>
 <20170329171314.GD10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170329171314.GD10760@atomide.com>
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
Cc: Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On 03/29/2017 12:13 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [170328 19:00]:
>> Hi,
>> This series contains the remaining code to enable suspend to mem and standby on
>> am335x and am437x platforms. It depends on the ti-emif-sram series sent here [1].
>
> Looks good to me in general. To remove the dependency, can some
> of this be merged separately without breaking things before [1]?
> Maybe by disabling some of the PM states until [1] is in place?

Thanks for the feedback. Actually, patch 7 is the only patch with a dependency 
to [1]. The rest of the patches just add platform PM support needed for suspend 
but won't do much of anything until patch 7 actually enables the suspend states, 
so there is no reason why patches 1-6 and patch 8 can't be merged now.

Regards,
Dave

>
> Regards,
>
> Tony
>
