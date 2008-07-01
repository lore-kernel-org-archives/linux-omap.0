From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP: DISPC: Fix to disable also interface clocks
Date: Tue, 01 Jul 2008 12:26:24 +0300
Message-ID: <8763rqx8e7.fsf@trdhcp146196.ntc.nokia.com>
References: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com>
	<20080701091343.GE9696@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62066 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYGAJ0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 05:26:37 -0400
In-Reply-To: <20080701091343.GE9696@kedavra.cpe.vivax.com.br> (ext Felipe
	Balbi's message of "Tue, 1 Jul 2008 12:13:43 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

"ext Felipe Balbi" <me@felipebalbi.com> writes:

> On Tue, Jul 01, 2008 at 10:12:41AM +0300, Jouni Hogander wrote:
>>  static void enable_lcd_clocks(int enable)
>>  {
>> -	if (enable)
>> +	if (enable) {
>> +		clk_enable(dispc.dss_ick);
>>  		clk_enable(dispc.dss1_fck);
>> -	else
>> +	}
>> +	else {
>
> should be } else { according to CodingStyle ;-)

Yes, thanks Felipe. I should have bother to use checkpatch.pl here. I
will send this again.

>
> --=20
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
