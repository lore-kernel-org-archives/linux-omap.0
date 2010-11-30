From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/5] OMAP3630: PM: Erratum i608: disable RTA
Date: Tue, 30 Nov 2010 08:15:32 -0600
Message-ID: <4CF50704.9060606@ti.com>
References: <1291061993-4740-1-git-send-email-nm@ti.com> <1291061993-4740-4-git-send-email-nm@ti.com> <AANLkTiktZPHxGJCTRUg63bR91J28mpw2Rf4riqrybMKV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55557 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027Ab0K3OPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 09:15:44 -0500
Received: by mail-gw0-f51.google.com with SMTP id 11so75214gwb.38
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 06:15:38 -0800 (PST)
In-Reply-To: <AANLkTiktZPHxGJCTRUg63bR91J28mpw2Rf4riqrybMKV@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Vishwa <vishwanath.bs@ti.com>

Varadarajan, Charulatha had written, on 11/30/2010 12:07 AM, the following:
> Nishant,
> 
> On Tue, Nov 30, 2010 at 01:49, Nishanth Menon <nm@ti.com> wrote:
>> Erratum id: i608
>> RTA (Retention Till Access) feature is not supported and leads to device
>> stability issues when enabled. This impacts modules with embedded memories
>> on OMAP3630
>>
>> Workaround is to disable RTA on boot and coming out of core off.
>> For disabling rta coming out of off mode, we do this by overriding the
>> restore pointer for 3630 to allow us restore handler as the first point of
>> entry before caches are touched and is common for GP and HS devices.
>> to disable earlier than this could be possible by modifying the ppa for HS
>> devices, but not for GP devices.
>>
>> Signed-off-by: Ambresh K <ambresh@ti.com>
> 
> not in Cc?
It was initially written by me and co-developed with Ambresh  and I took 
it up back again for upstreaming :)
> 
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> v2: fixed missing b restore for 3430 es3.1 code.
>>        introduced erratum handling logic here splitting it out of uart errata
>>        typo fixes for erratum
>> v1: http://marc.info/?l=linux-omap&m=129013172825240&w=2
>>
>>  arch/arm/mach-omap2/control.c   |    5 ++++-
>>  arch/arm/mach-omap2/control.h   |    5 +++++
>>  arch/arm/mach-omap2/pm34xx.c    |   23 +++++++++++++++++++++++
>>  arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++++
>>  4 files changed, 58 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
>> index 1fa3294..728f268 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
>>
>>        /* Populate the Scratchpad contents */
>>        scratchpad_contents.boot_config_ptr = 0x0;
>> -       if (omap_rev() != OMAP3430_REV_ES3_0 &&
>> +       if (cpu_is_omap3630())
>> +               scratchpad_contents.public_restore_ptr =
>> +                       virt_to_phys(get_omap3630_restore_pointer());
>> +       else if (omap_rev() != OMAP3430_REV_ES3_0 &&
>>                                        omap_rev() != OMAP3430_REV_ES3_1)
>>                scratchpad_contents.public_restore_ptr =
>>                        virt_to_phys(get_restore_pointer());
>> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
>> index b6c6b7c..d7911c5 100644
>> --- a/arch/arm/mach-omap2/control.h
>> +++ b/arch/arm/mach-omap2/control.h
>> @@ -204,6 +204,10 @@
>>  #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
>>  #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
>>
>> +/* 36xx-only RTA - Retention till Accesss control registers and bits */
>> +#define OMAP36XX_CONTROL_MEM_RTA_CTRL  0x40C
>> +#define OMAP36XX_RTA_DISABLE           0x0
>> +
>>  /* 34xx D2D idle-related pins, handled by PM core */
>>  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
>>  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
>> @@ -347,6 +351,7 @@ extern void omap3_save_scratchpad_contents(void);
>>  extern void omap3_clear_scratchpad_contents(void);
>>  extern u32 *get_restore_pointer(void);
>>  extern u32 *get_es3_restore_pointer(void);
>> +extern u32 *get_omap3630_restore_pointer(void);
>>  extern u32 omap3_arm_context[128];
>>  extern void omap3_control_save_context(void);
>>  extern void omap3_control_restore_context(void);
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 75c0cd1..bd426cc 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -54,6 +54,10 @@
>>  #define OMAP343X_TABLE_VALUE_OFFSET       0xc0
>>  #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
>>
>> +#define RTA_ERRATUM_i608               (1 << 0)
>> +static u16 pm34xx_errata;
>> +#define IS_PM34XX_ERRATUM(id)          (pm34xx_errata & (id))
>> +
>>  struct power_state {
>>        struct powerdomain *pwrdm;
>>        u32 next_state;
>> @@ -979,6 +983,14 @@ void omap_push_sram_idle(void)
>>                                save_secure_ram_context_sz);
>>  }
>>
>> +static void pm_errata_configure(void)
>> +{
>> +       if (cpu_is_omap34xx()) {
>> +               if (cpu_is_omap3630())
> 
> Is it required to have both the cpu_is checks*?  Why?
hmm... good point.. pm_init already checks of cpu_is_omap34xx() and 
returns.. I guess I was simply paranoid -> I will remove this in next 
rev. thanks.

-- 
Regards,
Nishanth Menon
