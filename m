From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 25 Mar 2011 12:36:57 -0500
Message-ID: <AANLkTikV37gmmf5sRQ98EzOL6K7JNvDy9gfCWbR=747k@mail.gmail.com>
References: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
	<4D8CD126.6000405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:44887 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360Ab1CYRg6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 13:36:58 -0400
Received: by mail-wy0-f182.google.com with SMTP id 23so2018329wyf.27
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 10:36:57 -0700 (PDT)
In-Reply-To: <4D8CD126.6000405@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, David Cohen <dacohen@gmail.com>, lak <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 25, 2011 at 12:30 PM, Sergei Shtylyov <sshtylyov@mvista.com=
> wrote:
> Hello.
>
> Omar Ramirez Luna wrote:
>
>> Commit d038aee24dcd changes iovmm to receive flags specified by user=
,
>
> =A0 Please also specify that commit's summary for the human readers. =
Bare ID
> is only usable to gitweb...

Here it is the patch, introducing the change:

https://patchwork.kernel.org/patch/620871/

If accepted by Hiroshi, I can update the description making reference
to this patch instead of commit.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
