From: Dave Hylands <dhylands@gmail.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 23:24:26 -0700
Message-ID: <CABi1daF7+Rzq-CWOOW3PVY3cgstBdvqZ0p_HMeLBNJiy1tVVbw@mail.gmail.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	<alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42993 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935243Ab1JFGY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 02:24:27 -0400
Received: by wwf22 with SMTP id 22so3717902wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 05 Oct 2011 23:24:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, sakoman@gmail.com

Hi Paul,

On Wed, Oct 5, 2011 at 11:09 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Dave,
>
> On Wed, 5 Oct 2011, Dave Hylands wrote:
>
>> I have an older overo board, which has an OMAP3503
>>
>> U-booot reports:
>> OMAP3503-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 mHz
>>
>> In order to get the 2.6.39 kernel to boot, I had to make 2 modificat=
ions:
>>
>> In arch/arm/mach-omap2/pm34xx.c, in the omap_sram_idle routine I had
>> to put an #if 0 around:
>>
>> #if 0
>> =A0 =A0 =A0 =A0if (omap3_has_io_wakeup() &&
>> =A0 =A0 =A0 =A0 =A0 =A0(per_next_state < PWRDM_POWER_ON ||
>> =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_POWER_ON)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_prm_set_mod_reg_bits(OMAP3430_E=
N_IO_MASK,
>> WKUP_MOD, PM_WKEN);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_enable_io_chain();
>> =A0 =A0 =A0 =A0}
>> #endif
>>
>> or I would get continuous
>>
>> Wake up daisy chain activation failed.
>>
>> messages on the console.
>
> Looking at the 2.6.39 kernel sources, those messages are coming from
> mach-omap2/pm34xx.c:omap3_enable_io_chain(). =A0That means that somet=
hing is
> seriously wrong since that code should only be executing on ES3.1 chi=
ps
> and higher.
>
> Could you put something similar to a
>
> pr_err("** omap_rev is %08x\n", omap_rev());
>
> in your pm34xx.c right above the #if 0 that you added and let us know=
 what
> it says?

It reports

** omap_rev is 35030234

--=20
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
