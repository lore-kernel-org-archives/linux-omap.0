From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC PATCH 1/6] usb: musb: omap: Configure OTG_INTERFSEL for
 proper charger detection
Date: Mon, 19 Sep 2011 20:26:08 +0530
Message-ID: <CANrkHUaNhzLgYhF745=cs8cNjjNL3nc884+AoFwRjz3WEUhCcw@mail.gmail.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
	<1316096403-6013-2-git-send-email-kishon@ti.com>
	<4E731B6D.2040007@ru.mvista.com>
	<CAAe_U6KaFJGM61=Pkm2q-EBQeEtSAOBuC2jgFRd7DV4xKOjJdg@mail.gmail.com>
	<20110916141339.GA31093@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38179 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751627Ab1ISO4K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 10:56:10 -0400
In-Reply-To: <20110916141339.GA31093@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@linux.intel.com, p-basak2@ti.com, x0153364@ti.com, m-sonasath@ti.com, vishp@ti.com, hemahk@ti.com

On Fri, Sep 16, 2011 at 7:43 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Sep 16, 2011 at 07:21:41PM +0530, ABRAHAM, KISHON VIJAY wrote=
:
>> Sergei,
>>
>> Thanks for your comments.
>>
>> On Fri, Sep 16, 2011 at 3:18 PM, Sergei Shtylyov <sshtylyov@mvista.c=
om> wrote:
>> > Hello.
>> >
>> > On 15-09-2011 18:19, Kishon Vijay Abraham I wrote:
>> >
>> >> Setting OTG_INTERFSEL to UTMI interferes with charger detection r=
esulting
>> >> in incorrect detection of charger type. Hence OTG_INTERFSEL is co=
nfigured
>> >> to
>> >> ULPI initially and changed to UTMI only after receiving USB_EVENT=
_ID or
>> >> USB_EVENT_VBUS notification.
>> >
>> >> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> >> Signed-off-by: Balaji T K<balajitk@ti.com>
>> >
>> > =A0 AFAIK, full name is needed here.
>>
>> is it not the prerogative of the person giving his signed-off by??
>
> Not really.
>

Certainly did not want to compete for long names :-)
But Is Real Name + unique email id not sufficient.
patches with this Signed-off  .

--=20
Thanks and Regards,
Balaji T K
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
