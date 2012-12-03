From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH v2 22/22] mfd: omap-usb-host: Don't spam console on clk_set_parent failure
Date: Mon, 03 Dec 2012 08:48:45 +0100
Message-ID: <87ehj7y3s2.fsf@nemi.mork.no>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
	<1354114150-11941-23-git-send-email-rogerq@ti.com>
	<50BB8B78.9010207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:45840 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab2LCHtB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 02:49:01 -0500
In-Reply-To: <50BB8B78.9010207@mvista.com> (Sergei Shtylyov's message of "Sun,
	02 Dec 2012 21:10:16 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Sergei Shtylyov <sshtylyov@mvista.com> writes:
> On 28-11-2012 18:49, Roger Quadros wrote:
>>   		ret =3D clk_set_parent(omap->utmi_clk[0],
>>   					omap->xclk60mhsp1_ck);
>>   		if (ret !=3D 0)
>> -			dev_err(dev, "xclk60mhsp1_ck set parent"
>> +			dev_dbg(dev, "xclk60mhsp1_ck set parent"
>
>    Need space at the end of this substring, else you get "parentfaile=
d"
>
>>   				"failed error:%d\n", ret);


Wouldn't it be better to change all these to conform with
Documentation/CodingStyle when touching them anyway?  That would make
the missing space problem obvious as well as making the messages
greppable.

=46rom Chapter 2: Breaking long lines and strings:

"However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them."



Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
