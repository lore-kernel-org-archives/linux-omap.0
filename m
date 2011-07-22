From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: PM: SR: add suspend/resume handlers
Date: Fri, 22 Jul 2011 08:53:12 -0500
Message-ID: <CAOMWX4djN8D1hWGuqRLkk53pVPghT_T=3FUkhJv8Hnu7CWQ8Mg@mail.gmail.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
	<1311314153-23531-3-git-send-email-nm@ti.com>
	<20110722091303.GK32058@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110722091303.GK32058@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Colin <ccross@google.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 22, 2011 at 04:13, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jul 22, 2011 at 12:55:53AM -0500, Nishanth Menon wrote:
>> Suspend and Resume paths are safe enough to do it in
>> the standard LDM suspend/resume handlers where one can
>> sleep. Add suspend/resume handlers for SmartReflex.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/smartreflex.c | =A0 87 ++++++++++++++++++++++++++=
+++++++++++
>> =A01 files changed, 87 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/sma=
rtreflex.c
>> index 33a027f..fb90bd2 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -39,6 +39,7 @@ struct omap_sr {
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
ip_type;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
nvalue_count;
>> =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
autocomp_active;
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is=
_suspended;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
clk_length;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
err_weight;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
err_minlimit;
>> @@ -684,6 +685,12 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>> =A0 =A0 =A0 if (!sr->autocomp_active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 if (sr->is_suspended) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&sr->pdev->dev, "%s: in suspended stat=
e\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>
> I wonder why you get these called if you're in suspend state. If this is
> called by some other driver, then shouldn't you pm_runtime_get_sync();
> do_whatever_you_need_to_do(); and pm_runtime_put(); rather then just
> returning ?

because we have two state machines running in parallel - cpu idle and
dvfs(cpufreq, and other dependent domain voltage scaling) and SR
driver is just one - it does it's own get_sync and put_sync_suspend.
we cannot guarentee that the SR enable/disable calls can be properly
sequenced unless we use suspend lockouts. SmartReflex driver is an
independent entity of it's own - yeah we can do the same as we have
done historically in the omap[34]_idle paths(which is disable SR after
we have disabled interrupts), but in case of suspend(unlike in idle),
we do *know* that SR will have to be disabled - hence doing it earlier
as part of standard LDM suspend sequences is more opportunistic.

Regards,
Nishanth Menon
