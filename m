From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes
Date: Fri, 13 Jan 2012 11:35:13 +0100
Message-ID: <CAMQu2gzMnXgTAM7V1ZOvgtX5CoDXywc2-hKj+BqUWg5EDH4YdQ@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk>
 <20120112201112.GB16726@n2100.arm.linux.org.uk> <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
 <20120112202712.GC16726@n2100.arm.linux.org.uk> <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
 <20120112210055.GD16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55284 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752625Ab2AMKff convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 05:35:35 -0500
Received: by mail-qw0-f42.google.com with SMTP id 2so653387qam.15
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 02:35:34 -0800 (PST)
In-Reply-To: <20120112210055.GD16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 10:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 12, 2012 at 09:32:40PM +0100, Shilimkar, Santosh wrote:
>> OK. Point taken.
>
> Can you also explain this in the code:
>
> =A0 =A0 =A0 =A0size =3D ALIGN(PAGE_SIZE, SZ_1M);
>
> Isn't that just SZ_1M written in a rather complex way? =A0A comment m=
ay be
> a better way of explaining it.

memblock alloc was failing without the alignment IIRC. Will add comment=
s
about the same.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
