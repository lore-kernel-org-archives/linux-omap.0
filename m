From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in
 musb_g_tx
Date: Thu, 16 Sep 2010 09:22:32 +0300
Message-ID: <20100916062232.GC3393@legolas.emea.dhcp.ti.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
 <20100915105641.GO3393@legolas.emea.dhcp.ti.com>
 <AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com>
 <20100915110745.GP3393@legolas.emea.dhcp.ti.com>
 <4C90C5B7.7050103@ru.mvista.com>
 <20100916060520.GA3393@legolas.emea.dhcp.ti.com>
 <AANLkTi=y-HfvDOvhW-WhLFq5TUCjGA-52cuyByCHMvvV@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=y-HfvDOvhW-WhLFq5TUCjGA-52cuyByCHMvvV@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 16, 2010 at 01:15:32AM -0500, Gadiyar, Anand wrote:
>On Thu, Sep 16, 2010 at 11:35 AM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> On Wed, Sep 15, 2010 at 08:10:15AM -0500, Sergei Shtylyov wrote:
>>>
>>> =A0 I don't see what to rework. The last short packet should still =
satisfy
>>> (request->actual =3D=3D request->length) condition, no?
>>
>> of course not, it's short not zero. so the last short packet can be
>> anything from 1 to 511 bytes.
>>
>
>If it's TX, both condtions should automatically be true, right?

even in mode1 ? I have to revist my docs, but afaict mode1 won't
transmit last short packet, no matter if it's tx or rx. Could be wrong,
though.

--=20
balbi
