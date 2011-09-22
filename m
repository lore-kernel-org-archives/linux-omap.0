From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 01/12] OMAP2+: dmtimer: add device names to flck nodes
Date: Thu, 22 Sep 2011 11:28:23 +0530
Message-ID: <CAC83Zv+2ro-=en0tpdvrs1Ejzyj9Od54YadqgG-Bhksjn+wcmg@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
	<20110922010031.GR2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53458 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1IVF6Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 01:58:25 -0400
Received: by mail-bw0-f42.google.com with SMTP id r4so2611878bka.15
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 22:58:24 -0700 (PDT)
In-Reply-To: <20110922010031.GR2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

On Thu, Sep 22, 2011 at 6:30 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes c=
an be
>> retrieved by doing a clk_get with the corresponding device pointers =
or
>> device names.
>>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com
>
> I've fixed the missing bracket in the email address =A0 =A0 ^^^
Thanks.
--
Tarun
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
