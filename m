From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Wed, 26 Jan 2011 15:46:21 +0530
Message-ID: <AANLkTik6zf1GcPHxSv5pBOHVf=GjCPMuNf-qvpTgiyqT@mail.gmail.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
	<AANLkTi=PqUBrrZwWbipXDNxoKrcX8MefZjdeaOrgPApV@mail.gmail.com>
	<20110125192836.GP13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110125192836.GP13589@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 26, 2011 at 12:58 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Poddar, Sourav <sourav.poddar@ti.com> [110125 07:45]:
>>
>> Just FYI, I observed similar results on OMAP4 for these patches.
>> For OMAP2420, OMAP2430 and OMAP3430 SDPs, you can add my boot
>> Tested-by: Sourav Poddar<sourav.poddar@ti.com>
>
> Thanks, just posted third patch to this thread that fixes things
> for omap4, care to give that a try too?
>

I applied the third patch and now its booting
fine for OMAP4 also. :)

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
