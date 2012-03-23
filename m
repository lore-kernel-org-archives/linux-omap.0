From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Fri, 23 Mar 2012 13:17:29 +0530
Message-ID: <CAMrsUdKn6i9cNfHia+TqZ2By7V3NhXHF+1Bt-eadJd0ZWkERNQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com>
 <87limurpsx.fsf@ti.com> <CAMrsUdLtC0iVk2qDDDXj2tteAzP5UQJXNvsCoJLEC9Yty2QjvQ@mail.gmail.com>
 <alpine.DEB.2.00.1203221740140.24425@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:44365 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753110Ab2CWHrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 03:47:51 -0400
Received: by obhx4 with SMTP id x4so2771147obh.2
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 00:47:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203221740140.24425@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Hi Paul,

On Fri, Mar 23, 2012 at 5:10 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 22 Mar 2012, Raja, Govindraj wrote:
>
>> Sorry I for got to add that, here are details on what was tested.
>>
>> 1.) OMAP2430 SDP : Boot tested with uart1 as console.
>>
>> 2.) OMAP3430 SDP: Boot test, suspend/resume tests, retention off mod=
e
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(chec=
king retention and off mode count
>> in cpu idle cases)
>>
>> 3.) OMAP3630 - Beagle XM: =A0Boot test, suspend/resume tests, retent=
ion off mode
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (checking retention and
>> off mode count in cpu idle cases)
>>
>> 4.) OMAP4430 - PANDA: Boot test, suspend/resume tests
>>
>> 5.) OMAP4460 - PANDA: Boot test.
>
> What kernel .config was used for these tests?

omap2plus_defconfig was used.

the same kernel image was tested with all these boards.
(kernel image was built along with initramfs support
using minimal busybox filesystem)

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
