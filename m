From: Ramesh Gupta Guntha <grgupta77@gmail.com>
Subject: Re: DSP MMU Fault
Date: Fri, 5 Jun 2009 09:18:22 +0530
Message-ID: <3a2dabf50906042048r24b69ee2v814fa29c83450bff@mail.gmail.com>
References: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:64984 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbZFEDsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 23:48:21 -0400
Received: by gxk10 with SMTP id 10so2285188gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 20:48:22 -0700 (PDT)
In-Reply-To: <44449.139.179.13.76.1244116436.squirrel@newmail.bilkent.edu.tr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Can Bal <canbal@ee.bilkent.edu.tr>
Cc: linux-omap@vger.kernel.org

Hi Can,


On 6/4/09, Can Bal <canbal@ee.bilkent.edu.tr> wrote:
> Hi everyone,
>
> I'm implementing a code on DSP but at the time I do a memory allocation at
> the DSP side as:
>
> short *a;
> a = malloc(192); // (short*)malloc(192) does not work either
>
> But at this line I get the following error and DSP fails afterwards. Then
> I need to reboot until I can run the application again.
>
> <6>***** DSPMMU FAULT ***** IRQStatus 0x2
> ***** DSPMMU FAULT ***** IRQStatus 0x2
> <6>***** DSPMMU FAULT ***** faultAddr 0x230674a0
> ***** DSPMMU FAULT ***** faultAddr 0x230674a0
> <6>WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> WMD_DEH_Notify: ********** DEVICE EXCEPTION **********
> <6>WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
> WMD_DEH_Notify: DSP_MMUFAULT,errInfo = 0x0
> <6>WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
> WMD_DEH_Notify: DSP_MMUFAULT, High Address = 0x2306
> <6>WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
> WMD_DEH_Notify: DSP_MMUFAULT, Low Address = 0x74a0
> <6>WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
> WMD_DEH_Notify: DSP_MMUFAULT, fault address = 0x230674a0
>
> Do you have any ideas why this might be happening and how to fix it?
> Thanks a lot.
>

This means that the DSP is trying to access a virtual memory for which
no physical memory present, Can you please check why the memory
allocation failing on the DSP?

regards
Ramesh
