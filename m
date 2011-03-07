From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Mon, 7 Mar 2011 10:26:03 +0000
Message-ID: <AANLkTimV_mygA+2iBLPO2WvLBGTjEfUTHjCyMFn6wuYj@mail.gmail.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
	<7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
	<20110304174709.GB20560@atomide.com>
	<AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
	<87r5amftpx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43302 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab1CGK0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 05:26:04 -0500
Received: by yxs7 with SMTP id 7so1557592yxs.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 02:26:03 -0800 (PST)
In-Reply-To: <87r5amftpx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

On Fri, Mar 4, 2011 at 9:42 PM, Kevin Hilman <khilman@ti.com> wrote:
> Dave Martin <dave.martin@linaro.org> writes:
>
>> On Fri, Mar 4, 2011 at 5:47 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110304 09:36]:
>>>> >
>>>> > Following up on this, it looks like I have some locally-recorded
>>>> > acks
>>>> > which didn't make it into my posting ...
>>>
>>> To me looks like this is ready to go, but I'd like to see Kevin's
>>> acks on this one as this touches the PM code.
>>>
>>> Or if Kevin wants to take the series, here's my ack for the series:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Yeah, I'll queue this series.
>
>> Thanks -- I'll wait for Kevin to comment also.
>
> I have to give one more round of sanity testing to this series, but
> otherwise I have no outstanding issues. =A0I also need to coordinate =
with
> Santosh on this because he has an additional cleanup series that touc=
hes
> the same code.
>
> Dave, just to confirm something The outstanding toolchain bugs only
> affect compiling in Thumb-2 mode, right? =A0IOW, if I merge just this
> series (without having the other toolchain workaround patches) we sho=
uld
> still be able to compile/run fine in ARM mode, correct?

Yes, that's right.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
