From: "Can Bal" <canbal@ee.bilkent.edu.tr>
Subject: RE: DSP MMU Fault
Date: Fri, 5 Jun 2009 01:14:48 +0300 (EEST)
Message-ID: <50125.78.164.152.255.1244153688.squirrel@newmail.bilkent.edu.tr>
References: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
    <8F7AF80515AF0D4D93307E594F3CB40E2F13B302@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ispinoz.bcc.bilkent.edu.tr ([139.179.10.240]:43789 "EHLO
	ispinoz.bcc.bilkent.edu.tr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823AbZFDWOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 18:14:40 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2F13B302@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Can Bal <canbal@ee.bilkent.edu.tr>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

How can I map the address? At what part do I specify these mappings;
bridge installation, at DSP side program (with the tci file etc.)? By the
way just before that in the program I do a malloc(32) to another short
pointer but |it doesn't return any errors?

Please forgive me if this is a trivial question but I'm just learning the
DSP programming. Thanks a lot.

Best regards,
Can


> Hi Can,
>
>> Do you have any ideas why this might be happening and how to fix it?
>> Thanks a lot.
>
> Most probably you might not have mapped the address 0x230674a0.
>
>
> Thank you,
> Best regards,
> Hari
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Can Bal
>> Sent: Thursday, June 04, 2009 6:54 AM
>> To: linux-omap@vger.kernel.org
>> Subject: DSP MMU Fault
>>
>> Hi everyone,
>>
>> I'm implementing a code on DSP but at the time I do a memory allocation
>> at
>> the DSP side as:
>>
>> short *a;
>> a = malloc(192); // (short*)malloc(192) does not work either
>>
>> But at this line I get the following error and DSP fails afterwards.
>> Then
>> I need to reboot until I can run the application again.
>>
>> <6>***** DSPMMU FAULT ***** IRQStatus 0x2
>> ***** DSPMMU FAULT ***** IRQStatus 0x2
>> <6>***** DSPMMU FAULT ***** faultAddr 0x230674a0
>> ***** DSPMMU FAULT ***** faultAddr 0x230674a0
>> <6>WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
>> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
>> <6>WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
>> WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
>> <6>WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
>> WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
>> <6>WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
>> WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
>> <6>WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
>> WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
>>
>> Do you have any ideas why this might be happening and how to fix it?
>> Thanks a lot.
>>
>> Can
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


