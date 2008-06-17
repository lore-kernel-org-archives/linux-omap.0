From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Tue, 17 Jun 2008 15:09:48 +0300
Message-ID: <87d4mg460j.fsf@trdhcp146196.ntc.nokia.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com>
	<1213687871-30038-1-git-send-email-jouni.hogander@nokia.com>
	<663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56798 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbYFQMK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 08:10:27 -0400
In-Reply-To: <663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com> (ext Felipe
	Balbi's message of "Tue, 17 Jun 2008 06:31:44 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

"ext Felipe Balbi" <me@felipebalbi.com> writes:

> On Tue, 17 Jun 2008 10:31:11 +0300, Jouni Hogander
> <jouni.hogander@nokia.com> wrote:
>> Current hsmmc is not pm friendly. Disable it because it prevents oma=
p3
>> retention
>
> Disabling will just hide the bug. Better making it modular
> and let mmc guys dig on it.

Ok, I can change it, if this set needs to be sent again. I think
disabling mmc increases visibility of its PM problems. I mean missing
mmc driver is more visible than missing PM in this case.

>
> What do you need to make it more pm friendly?

Not to prevent omap retention.

>
> --=20
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
