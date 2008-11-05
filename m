From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH 1/2] Add touchscreen support for Pandora
Date: Thu, 6 Nov 2008 01:41:46 +0200
Message-ID: <6ed0b2680811051541t21a1be36i8ba85db9bfaaa025@mail.gmail.com>
References: <1225919983-26144-1-git-send-email-notasas@gmail.com>
	 <20081105223920.GG4010@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:24356 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbYKEXls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:41:48 -0500
Received: by ug-out-1314.google.com with SMTP id 39so671482ugf.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Nov 2008 15:41:47 -0800 (PST)
In-Reply-To: <20081105223920.GG4010@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

On Thu, Nov 6, 2008 at 12:39 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Wed, Nov 05, 2008 at 11:19:42PM +0200, Grazvydas Ignotas wrote:
>> +
>> +#ifndef __ASM_ARCH_OMAP3_PANDORA_H
>> +#define __ASM_ARCH_OMAP3_PANDORA_H
>> +
>> +#define      OMAP3_PANDORA_TS_GPIO           94
>
> for one define only ???
>
> Do you have plans to add more stuff here ? Do you have any other files
> that might need this define besides the main board-file ??
>
> Looks unnecessary to add yet another header for one define only. Moving
> to the board-file would be more acceptable.

Yes, it's more like a placeholder for future patches. I plan to add a
function prototype and some more GPIOs. I also plan adding another
board file for input stuff (board-omap3pandora-input.c), as pandora
has lots of GPIO buttons with full qwerty keypad, and I don't want to
clutter the main board file with large arrays of structures.
If this is not acceptable I can stuff everything into board-omap3pandora.c
