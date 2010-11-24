From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v4 4/5] OMAP: mailbox: send message in process context
Date: Wed, 24 Nov 2010 07:14:36 -0600
Message-ID: <AANLkTikaqT5wCOiDERgSh4EeOzuO16LZ-ydfSJhRLoXP@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
	<1290547617-16640-5-git-send-email-h-kanigeri2@ti.com>
	<AANLkTimbXXmPu5KQtpxG6jTxaj18ad+Q5dHSPArEtXgr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53569 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679Ab0KXNOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 08:14:37 -0500
Received: by pwj4 with SMTP id 4so2405850pwj.10
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 05:14:36 -0800 (PST)
In-Reply-To: <AANLkTimbXXmPu5KQtpxG6jTxaj18ad+Q5dHSPArEtXgr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, Nov 23, 2010 at 11:26 PM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote:
>> Schedule the Tasklet to send only when mailbox fifo is full and there are
>> pending messages in kifo, else send the message directly in the Process
>
> Typo -> kifo

Thanks :). My bad I I think overlooked Felipe's comment on my previous patch.

Thank you,
Best regards,
Hari Kanigeri
