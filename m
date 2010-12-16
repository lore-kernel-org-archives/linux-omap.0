From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v3] OMAP3: clean up ASM idle code
Date: Thu, 16 Dec 2010 19:17:04 +0100
Message-ID: <AANLkTina03chWbrBUAQXxb03s_h-JCbJA-Hz+sdv2wzD@mail.gmail.com>
References: <1292347603-17703-1-git-send-email-j-pihet@ti.com>
	<20101214224214.GB14990@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52108 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228Ab0LPSRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:17:05 -0500
Received: by vws16 with SMTP id 16so1511235vws.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 10:17:04 -0800 (PST)
In-Reply-To: <20101214224214.GB14990@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

Tony,

On Tue, Dec 14, 2010 at 11:42 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> Hi Jean,
>
> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [101214 09:28=
]:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch only contains clean-ups and cosmetic changes,
>> no functional change.
>>
>> Clean up of the ASM code:
>> - reorganized the code in logical sections: defines, API
>> =A0 =A0functions, internal functions and variables,
>> - reworked and simplified the execution paths, for better
>> =A0 =A0readability and to avoid duplication of code,
>> - added comments on the entry and exit points and the interaction
>> =A0 =A0with the ROM code for OFF mode restore,
>> - reworked the existing comments for better readability,
>> - reworked the code formating, alignment and white spaces,
>> - added comments for the i443 erratum workarounds,
>> - changed the hardcoded values in favor of existing macros
>> =A0 =A0from include files,
>> - clean up of non used symbols.
>
> Can you please split it further, it's not obvious from reading it
> that it does not change anything.
That makes sense indeed.

> How about first do one or more patches to move the code around.
> Then rework the comments and formatting.
I just re-sent the changes as a series '[PATCH 0/7 v4] OMAP3: clean up
ASM sleep code'.
The patches are now much more readable and it also allowed me to solve
issues in a more generic way, cf. for example '[PATCH 2/7] OMAP2+: use
global values for the SRAM PA addresses'.

>
> Thanks,
>
> Tony
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
