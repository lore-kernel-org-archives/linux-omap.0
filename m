From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 06/12] omap: mailbox: Flush posted write when acking mailbox
 irq
Date: Fri, 25 Sep 2009 10:12:21 +0300
Message-ID: <4ABC6D55.3000108@gmail.com>
References: <20090924233027.6065.95725.stgit@localhost> <20090924233920.6065.16789.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56456 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZIYHPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Sep 2009 03:15:30 -0400
In-Reply-To: <20090924233920.6065.16789.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On 09/25/2009 02:39 AM, Tony Lindgren wrote:
> From: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>
> The only way to flush posted write to L4 bus is to do a read back
> of the same register right after the write.

Just curious, is it really necessary to read back the _same_ register?
Would reading back any L4 bus-related register be sufficient?

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
