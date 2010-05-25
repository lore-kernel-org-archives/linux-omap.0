From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 14/14] omap: mailbox: reorganize headers
Date: Tue, 25 May 2010 21:04:25 +0300
Message-ID: <AANLkTik3wBTU4fiGdG7E_axF7gquYHzLI4Rx8EIQmpUw@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	 <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
	 <20100524171634.GA23202@nokia.com>
	 <AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
	 <20100525054947.GA26007@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f52.google.com ([209.85.214.52]:42055 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab0EYSE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 14:04:27 -0400
Received: by bwz8 with SMTP id 8so173838bwz.11
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 11:04:25 -0700 (PDT)
In-Reply-To: <20100525054947.GA26007@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>

Hello,

On Tue, May 25, 2010 at 8:49 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> On Mon, May 24, 2010 at 09:14:24PM +0200, ext Felipe Contreras wrote:
>> Now, I am pretty sure that platform_device.h will always depend on
>> device.h that's why I removed them, but I can add them again if
>> somebody wants to, but again, the situation is already bad.
>
> so there's platform_device.h on that file, a little comment on the changelog
> would suffice to avoid this kind of mis-understanding.

Sure, will do.

-- 
Felipe Contreras
