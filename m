From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH v4] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Tue, 28 Sep 2010 11:37:46 +0300
Message-ID: <AANLkTikZqtXa2YQsDehoWVMRstefUyafsQn2mph7U3CZ@mail.gmail.com>
References: <1285618704-8985-1-git-send-email-notasas@gmail.com>
	<20100928060554.GF2702@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45350 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0I1Ihr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 04:37:47 -0400
In-Reply-To: <20100928060554.GF2702@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

On Tue, Sep 28, 2010 at 9:05 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Sep 27, 2010 at 03:18:24PM -0500, Grazvydas Ignotas wrote:
>>
>> +static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned =
long
>> val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *p=
riv)
>> +{
>> + =A0 =A0 =A0 struct twl4030_bci *bci =3D container_of(nb, struct tw=
l4030_bci,
>> otg_nb);
>> +
>> + =A0 =A0 =A0 dev_dbg(bci->dev, "OTG notify %lu\n", val);
>> +
>> + =A0 =A0 =A0 switch (val) {
>> + =A0 =A0 =A0 case USB_EVENT_VBUS:
>> + =A0 =A0 =A0 case USB_EVENT_CHARGER:
>
> you should have removed CHARGER from here :-)

hm why? Don't recall you commenting on that, why can't I charge from ch=
arger?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
