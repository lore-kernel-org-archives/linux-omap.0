From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: dma: Correct CPU version check for dma_common_ch_end
Date: Thu, 23 Feb 2012 11:04:28 +0200
Message-ID: <4F46011C.7090905@ti.com>
References: <1329470706-29682-1-git-send-email-peter.ujfalusi@ti.com> <20120222230714.GV18185@atomide.com> <4F45EAC1.5070309@ti.com> <CAMQu2gxhQNVoKWQ_gGS12U9WN9iOUdGgERiV95o4s1Bgpp+rJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50540 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab2BWJEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 04:04:21 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m6so137240lag.9
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 01:04:19 -0800 (PST)
In-Reply-To: <CAMQu2gxhQNVoKWQ_gGS12U9WN9iOUdGgERiV95o4s1Bgpp+rJg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 02/23/2012 10:42 AM, Shilimkar, Santosh wrote:
> The bug is not severe. Infact these registers are needed for
> descriptor loading sDMA feature which never made it to mainline :)
> So nothing should get impacted.

Yes, this is my understanding as well.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
