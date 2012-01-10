From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support
 via hwmod mux
Date: Tue, 10 Jan 2012 09:47:26 -0800
Message-ID: <4F0C79AE.308@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com> <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com> <8739bnsb6o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50593 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756511Ab2AJRr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:47:28 -0500
Received: by mail-yx0-f174.google.com with SMTP id m10so1012904yen.33
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:47:27 -0800 (PST)
In-Reply-To: <8739bnsb6o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/10/2012 09:46 AM, Kevin Hilman wrote:
> Vishwanath BS<vishwanath.bs@ti.com>  writes:
>
>> >  IO Daisychain feature has to be triggered whenever there is a change in
>> >  device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
 >
> ...in addition to the triggering still happening in the idle path,
> right?   IIUC, after this series, there's still a call in omap_sram_idle().

oops, please ignore this comment.  I see the answer in PATCH 6/7.

Sorry for the noise.

Kevin


