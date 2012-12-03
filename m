From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 22/22] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Mon, 3 Dec 2012 17:50:04 +0200
Message-ID: <50BCCA2C.5060609@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-23-git-send-email-rogerq@ti.com> <50BB8B78.9010207@mvista.com> <87ehj7y3s2.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87ehj7y3s2.fsf-lbf33ChDnrE/G1V5fR+Y7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/03/2012 09:48 AM, Bj=C3=B8rn Mork wrote:
> Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> writes:
>> On 28-11-2012 18:49, Roger Quadros wrote:
>>>   		ret =3D clk_set_parent(omap->utmi_clk[0],
>>>   					omap->xclk60mhsp1_ck);
>>>   		if (ret !=3D 0)
>>> -			dev_err(dev, "xclk60mhsp1_ck set parent"
>>> +			dev_dbg(dev, "xclk60mhsp1_ck set parent"
>>
>>    Need space at the end of this substring, else you get "parentfail=
ed"
>>
>>>   				"failed error:%d\n", ret);
>=20
>=20
> Wouldn't it be better to change all these to conform with
> Documentation/CodingStyle when touching them anyway?  That would make
> the missing space problem obvious as well as making the messages
> greppable.
>=20
> From Chapter 2: Breaking long lines and strings:
>=20
> "However, never break user-visible strings such as printk messages,
> because that breaks the ability to grep for them."
>=20

Agreed. I'll fix it in next spin. Thanks.

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
