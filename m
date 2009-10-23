From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 12/32] OMAP: PM: DMA context save/restore for off-mode  support
Date: Fri, 23 Oct 2009 10:33:56 -0700
Message-ID: <871vkuggl7.fsf@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<6ed0b2680910230132o3a193659g5526f8c9c479680f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:48300 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZJWRdz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 13:33:55 -0400
Received: by qyk4 with SMTP id 4so6818627qyk.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 10:34:00 -0700 (PDT)
In-Reply-To: <6ed0b2680910230132o3a193659g5526f8c9c479680f@mail.gmail.com> (Grazvydas Ignotas's message of "Fri\, 23 Oct 2009 11\:32\:26 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

>> =A0static int __init omap_init_dma(void)
>> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-o=
map/include/plat/dma.h
>> old mode 100644
>> new mode 100755
>
> ^^ whoops?
>

Good catch, I'll fix this up in my pm-off branch.

Kevin

>> index 72f680b..1c017b2
>> --- a/arch/arm/plat-omap/include/plat/dma.h
>> +++ b/arch/arm/plat-omap/include/plat/dma.h
>> @@ -633,6 +633,11 @@ extern void omap_set_dma_dst_endian_type(int lc=
h, enum end_type etype);
>> =A0extern void omap_set_dma_src_endian_type(int lch, enum end_type e=
type);
>> =A0extern int omap_get_dma_index(int lch, int *ei, int *fi);
>>
>> +void omap_dma_global_context_save(void);
>> +void omap_dma_global_context_restore(void);
>> +
>> +extern void omap_dma_disable_irq(int lch);
>> +
>> =A0/* Chaining APIs */
>> =A0#ifndef CONFIG_ARCH_OMAP1
>> =A0extern int omap_request_dma_chain(int dev_id, const char *dev_nam=
e,
>> --
>> 1.6.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
