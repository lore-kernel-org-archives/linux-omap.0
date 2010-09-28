From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Tue, 28 Sep 2010 11:42:51 +0300
Message-ID: <20100928084251.GC3900@legolas.emea.dhcp.ti.com>
References: <1285618704-8985-1-git-send-email-notasas@gmail.com>
 <20100928060554.GF2702@legolas.emea.dhcp.ti.com>
 <AANLkTikZqtXa2YQsDehoWVMRstefUyafsQn2mph7U3CZ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikZqtXa2YQsDehoWVMRstefUyafsQn2mph7U3CZ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 28, 2010 at 03:37:46AM -0500, Grazvydas Ignotas wrote:
>On Tue, Sep 28, 2010 at 9:05 AM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> On Mon, Sep 27, 2010 at 03:18:24PM -0500, Grazvydas Ignotas wrote:
>>>
>>> +static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned=
 long
>>> val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *=
priv)
>>> +{
>>> + =A0 =A0 =A0 struct twl4030_bci *bci =3D container_of(nb, struct t=
wl4030_bci,
>>> otg_nb);
>>> +
>>> + =A0 =A0 =A0 dev_dbg(bci->dev, "OTG notify %lu\n", val);
>>> +
>>> + =A0 =A0 =A0 switch (val) {
>>> + =A0 =A0 =A0 case USB_EVENT_VBUS:
>>> + =A0 =A0 =A0 case USB_EVENT_CHARGER:
>>
>> you should have removed CHARGER from here :-)
>
>hm why? Don't recall you commenting on that, why can't I charge from c=
harger?

Charger event is SENT by charger driver when it verifies it's attached
to a wall charger.

--=20
balbi
