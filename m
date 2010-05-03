From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Mon, 3 May 2010 15:58:10 -0700
Message-ID: <h2h8bb80c381005031558vd5a150a2t74b753ceb59ed742@mail.gmail.com>
References: <1272922018-11388-1-git-send-email-mike@android.com>
	 <871vdssj6m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48667 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759645Ab0ECW6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 18:58:11 -0400
Received: by pxi5 with SMTP id 5so494475pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 15:58:11 -0700 (PDT)
In-Reply-To: <871vdssj6m.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com

On Mon, May 3, 2010 at 3:40 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> IO events can also come from GPIO modules, which reside in the PER d=
omain.
>> It is possible for the PER to enter RET while CORE is still in ON.
>> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
>> wakeup in this case, unless we enable it.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
>
> Thanks for moving this up to before the potential transition of PER.
>
> But...
>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 14 ++++++++++----
>> =A01 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index ea0000b..2b2eaaa 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -371,6 +371,13 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 if (pwrdm_read_pwrst(neon_pwrdm) =3D=3D PWRDM_POWER_ON)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_next_pwrst(neon_pwrdm, mpu_nex=
t_state);
>>
>> + =A0 =A0 /* Enable IO-PAD and IO-CHAIN wakeups */
>> + =A0 =A0 if (per_next_state < PWRDM_POWER_ON ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_PO=
WER_ON) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_=
MOD, PM_WKEN);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_enable_io_chain();
>> + =A0 =A0 }
>> +
>
> oops, both next_states will always be PWRDM_POWER_ON here as they
> haven't yet been read...
>
>> =A0 =A0 =A0 /* PER */
>> =A0 =A0 =A0 per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
>> =A0 =A0 =A0 core_next_state =3D pwrdm_read_next_pwrst(core_pwrdm);
>
> until here.

Sloppy me, I'll send out a v2 that fixes this. Thanks Kevin for catchin=
g this.

-- Mike

>
> Kevin
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
