From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP Mailbox framework adoption & DT support
Date: Mon, 14 Jul 2014 16:53:41 -0500
Message-ID: <53C45165.2030707@ti.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>	<CAPdLdq=ZnPBQiGVbKOk8G5soP=uPYpT7mEjigpR=W1Hc4btV3g@mail.gmail.com>	<53C3FE0C.4080502@ti.com> <CAPdLdqnd36QQ5v9-owiSFptbdkDxyYXjfRW=PdvaXKUr3B6_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPdLdqnd36QQ5v9-owiSFptbdkDxyYXjfRW=PdvaXKUr3B6_pQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <markus.mayer@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Markus,

>
>> There are couple of dependent preparatory series. You probably missed
>> the following in the cover letter.
>>> The series depends on the OMAP mailbox cleanup series [5] and the
>>> refreshed OMAP mailbox DT/hwmod cleanup series [2].
>>
>> As long as you pick the two dependent series, they apply fine on any of
>> the 3.16-rcs. I have posted all the series based on 3.16-rc2. Here's a
>> merged branch for your reference (not for pulling though, it has one
>> additional commit to allow me to test on OMAP2)
>> https://github.com/sumananna/mailbox/commits/submit/3.16-rc2-omap-mbox-v8-fwk-v2
>>
>> The last 2 patches in the series also depend on the mailbox framework
>> patches from Jassi to not throw any build errors if enabled.
> 
> That worked. Thanks for the pointer. FYI, there is a minor merge
> conflict rebasing the series onto 3.16-rc5.
> 
> Applying: ARM: OMAP2+: Avoid mailbox legacy device creation for DT-boot
> Using index info to reconstruct a base tree...
> M arch/arm/mach-omap2/devices.c
> Falling back to patching base and 3-way merge...
> Auto-merging arch/arm/mach-omap2/devices.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/devices.c
> Failed to merge in the changes.
> Patch failed at 0029 ARM: OMAP2+: Avoid mailbox legacy device creation
> for DT-boot
> 
> That's due to this commit:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1d29a0722f6c38f79785c9ffb911730598de84e2

OK, thanks, that's because of the removal of the line immediately above
the omap_init_mbox() deletion. Anyway, that should be a trivial rebase
and the patch contents should remain the same. Once OMAP3 becomes
DT-boot only, I will submit a patch to delete the omap_init_mbox().

regards
Suman
