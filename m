From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove empty io.h
Date: Sat, 19 Nov 2011 12:44:06 +0100
Message-ID: <4EC79686.5010608@gmail.com>
References: <1320755982-27005-1-git-send-email-weber@corscience.de> <20111119002916.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab1KSLoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Nov 2011 06:44:19 -0500
Received: by bke11 with SMTP id 11so4474828bke.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Nov 2011 03:44:18 -0800 (PST)
In-Reply-To: <20111119002916.GZ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

Hello Tony,

On 11/19/11 01:29, Tony Lindgren wrote:
> * Thomas Weber<weber@corscience.de>  [111108 04:05]:
>> The file arch/arm/mach-omap2/io.h is empty, so we can remove it.
> Thanks applying into fixes.
>
> Tony
>   
The "resend" version has an Acked-by from Kevin.

Thomas
>> Signed-off-by: Thomas Weber<weber@corscience.de>
>> ---
>>   0 files changed, 0 insertions(+), 0 deletions(-)
>>   delete mode 100644 arch/arm/mach-omap2/io.h
>>
>> diff --git a/arch/arm/mach-omap2/io.h b/arch/arm/mach-omap2/io.h
>> deleted file mode 100644
>> index e69de29..0000000
>> -- 
>> 1.7.7.2
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

