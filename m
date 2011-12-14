From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Wed, 14 Dec 2011 14:51:00 +0530
Message-ID: <CAAL8m4w28C3nWO65w=0bwoEvsOT3K9DS67dc5C0e-yuR+rc4Uw@mail.gmail.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com> <87zkewt5e0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53008 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab1LNJVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 04:21:22 -0500
In-Reply-To: <87zkewt5e0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

On Wed, Dec 14, 2011 at 5:02 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
> [...]
>
>> I have re-based this patch series against LO master
>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>
>> Same is available here [1]
>>
>> I have tested this patch series along with:
>>
>> 1.) Tero's V11 irq chaining series
>> =A0 =A0 =A0http://www.spinics.net/lists/linux-omap/msg61445.html
>> =A0 =A0 (This patch series is used for uart wakeup handling using
>> =A0 =A0 =A0 prcm_irq chaining)
>>
>> 2.) Rajendra's hwmod change
>> =A0 =A0 =A0http://www.spinics.net/lists/arm-kernel/msg148632.html
>> =A0 =A0 =A0(This patch handles init_no_idle flag setting
>> =A0 =A0 =A0 without this patch there will be boot warning however
>> =A0 =A0 =A0 all pm features will work after boot up.)
>
> Actually, without Rajendra's patch all features do not work. =A0I don=
't
> get UART console wakeups from idle (with runtime PM autosuspend enabl=
ed)
> on 3430/n900 or 3530/Overo without Rajendra's patch.

okay, I forgot last time when I tested without rajendra's patch was
with a custom activate func.
and now we have removed it.
Yes you are correct Rajendra's  patch + Tero's v11 series is a needed
for proper uart_runtime_pm functioning.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
