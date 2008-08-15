From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 0/4] Refreshed PM workaround patches
Date: Fri, 15 Aug 2008 10:04:18 +0300
Message-ID: <87zlnerc7h.fsf@trdhcp146196.ntc.nokia.com>
References: <877iaiu7np.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40528 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYHOHEy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 03:04:54 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7F74ELs019639
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 10:04:51 +0300
In-Reply-To: <877iaiu7np.fsf@trdhcp146196.ntc.nokia.com> (ext =?utf-8?Q?H?=
 =?utf-8?Q?=C3=B6gander?= Jouni's
	message of "Fri, 15 Aug 2008 09:14:18 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

ext H=C3=B6gander Jouni <jouni.hogander@nokia.com> writes:

> Hi,
>
> One more refreshed PM workaround set. Here are instructions, how to t=
est
> them:
>
> To get Omap into retention, this patch set still depends on:
> 1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)
>
> Test:
> 1. Apply dependency patch and workaround set on top of them
>
> 2. Enable disabling/enabling of gpio2-6 and uart clocks on idle:
>    $ echo 1 > /sys/power/clocks_off_while_idle
>
> 3. Try out static suspend:
>    $ echo mem > /sys/power/state
>    Wake up from suspend by entering character to serial console. This
>    should print out:
>    "Successfully put all powerdomains to target state"
>
> 4. Try out dynamic sleep:
>    $ echo 1 > /sys/power/sleep_while_idle
>    On Omap3430 SDP board VCORE_EN led can be used as an indicator. If
>    it starts to blink after a while then Omap enters retention on
>    idle. To make this work also display needs to be blanked.

Please ignore this set. It break 24xx build and patches contains
error. Sorry for this. I will send them again soon.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
