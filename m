From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in musb_g_tx
Date: Thu, 16 Sep 2010 11:45:32 +0530
Message-ID: <AANLkTi=y-HfvDOvhW-WhLFq5TUCjGA-52cuyByCHMvvV@mail.gmail.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com>
 <20100915105641.GO3393@legolas.emea.dhcp.ti.com> <AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com>
 <20100915110745.GP3393@legolas.emea.dhcp.ti.com> <4C90C5B7.7050103@ru.mvista.com>
 <20100916060520.GA3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:39674 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753119Ab0IPGPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 02:15:54 -0400
In-Reply-To: <20100916060520.GA3393@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

On Thu, Sep 16, 2010 at 11:35 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Sep 15, 2010 at 08:10:15AM -0500, Sergei Shtylyov wrote:
>>
>> =A0 I don't see what to rework. The last short packet should still s=
atisfy
>> (request->actual =3D=3D request->length) condition, no?
>
> of course not, it's short not zero. so the last short packet can be
> anything from 1 to 511 bytes.
>

If it's TX, both condtions should automatically be true, right?

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
