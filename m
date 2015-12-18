From: Adam Ford <aford173@gmail.com>
Subject: Re: OMAP display kconfig options changing
Date: Fri, 18 Dec 2015 08:03:35 -0600
Message-ID: <CAHCN7xJnHac+50TFSZ-+4Hqq9Of1HA6fTtnPxKUMCq_j5_UqgQ@mail.gmail.com>
References: <5673CA0D.4000706@ti.com>
	<20151218135342.GF23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151218135342.GF23396@atomide.com>
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
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tomi,

I'd like to also test the LogicPD Torpedo which has been using the FB
drivers until this point. I just pushed some LCD info for inclusion in
4.5, but if I need to make changes, I'd like to do that sooner than
later.  Any insturctions would be helpful.  Will this impact people
who use the SGX drivers?


Thanks

adam

On Fri, Dec 18, 2015 at 7:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 00:55]:
>> Hi Tony,
>>
>> I've just pushed a patch series to fbdev for-next branch which makes the
>> OMAP DRM and FB drivers independent of each other. This requires
>> changing the related Kconfig options.
>
> OK
>
>> What should I do with omap2plus_defconfig?
>>
>> At the moment omap2plus_defconfig enables the omapfb driver and panels
>> as modules. Should I change it to do the same with the new code? Or
>> should I change it to use omapdrm, which is the better maintained and
>> developed driver (although no one has probably tried omapdrm on omap2)?
>
> I'm all for changing omap2plus_defconfnig to use omapdrm.
>
> Do you have a link to a page we can point people to for instructions
> for what needs to be changed to get things working with omapdrm?
>
> For omap2, I can try to peek into my rack for n800.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
