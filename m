From: Grant Erickson <marathon96@gmail.com>
Subject: Re: ARM Architecture and GENERIC_CMOS_UPDATE
Date: Wed, 02 Feb 2011 08:57:46 -0800
Message-ID: <C96ECD0A.239F7%marathon96@gmail.com>
References: <20110201223252.GG3358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38328 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab1BBQ5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 11:57:54 -0500
Received: by iwn9 with SMTP id 9so160588iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 08:57:53 -0800 (PST)
In-Reply-To: <20110201223252.GG3358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 2/1/11 2:32 PM, Tony Lindgren wrote:
> * Grant Erickson <marathon96@gmail.com> [110128 16:34]:
>> Is there any reason, to date, that the ARM architecture has not had the
>> following kernel configuration option?
>> 
>> config GENERIC_CMOS_UPDATE
>>    def_bool y
> 
> Looks like it would just require implementing update_persitent_clock.
> No idea why it's not done for ARM , maybe send some patches for that?

Tony:

Thanks for the confirmation. For the time being, for my 2.6.32 kernel, I
added the following to my board-specific file:

#if defined(CONFIG_GENERIC_CMOS_UPDATE) && defined(CONFIG_RTC_LIB)
/**
 * update_persistent_clock - set the hardware clock time to system time
 * @now: the current system wall clock time.
 *
 * This routine attempts to access the primary hardware real-time
 * clock and, if successful, sets it to the current system wall clock
 * time.
 *
 * This generation (2.6.32) of ARM kernel has an alternative function
 * do_set_rtc in linux/arch/arm/kernel/time.c that does something
 * similar; however, in a more awkward and non-standard way. So much
 * so, that in 2.6.36 kernels, it's gone away entirely.
 *
 * This more or less matches what is in linux/arch/sparc/kernel/time_64.c
 *
 * Returns 0 if the real-time clock was successfully set to the system
 * wall clock time; otherwise, < 0 on error.
 */
int update_persistent_clock(struct timespec now)
{
    const char * name = "rtc0";
    struct rtc_device *rtc;
    int err = -ENODEV;

    rtc = rtc_class_open(name);

    if (rtc) {
        err = rtc_set_mmss(rtc, now.tv_sec);
        rtc_class_close(rtc);
    }

    return err;
}
#endif /* defined(CONFIG_GENERIC_CMOS_UPDATE) && defined(CONFIG_RTC_LIB) */

and changed arch/arm/kernel/time.c as follows:

--- a/linux/arch/arm/kernel/time.c
+++ b/linux/arch/arm/kernel/time.c
@@ -89,6 +89,9 @@ static unsigned long dummy_gettimeoffset(void)
 }
 #endif
 
+#if defined(CONFIG_GENERIC_CMOS_UPDATE)
+static inline void do_set_rtc(void) { return; }
+#else /* !defined(CONFIG_GENERIC_CMOS_UPDATE) */
 static unsigned long next_rtc_update;
 
 /*
@@ -118,6 +121,7 @@ static inline void do_set_rtc(void)
    else
        next_rtc_update = xtime.tv_sec + 660;
 }
+#endif /* defined(CONFIG_GENERIC_CMOS_UPDATE) */
 
 #ifdef CONFIG_LEDS
 
The long-term solution probably involves adding a function pointer member
field for each machine description with a generic, default function that
does something akin to the above board-specific approach.

Comments welcomed.

-Grant


