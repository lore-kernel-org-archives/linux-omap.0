From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Tue, 4 Dec 2012 16:46:47 +0200
Message-ID: <CANOLnONQ_xHDqhiOWxVgHG+sK9ROcqS5xnmoL2V=XtatFHN+jQ@mail.gmail.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
	<87fw49cnvh.fsf@deeprootsystems.com>
	<50AA05C3.7010003@ti.com>
	<876251b2kq.fsf@deeprootsystems.com>
	<50B4D167.4090205@ti.com>
	<20121127163022.GB24240@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121127163022.GB24240-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 27, 2012 at 6:30 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Tue, Nov 27, 2012 at 04:42:47PM +0200, Roger Quadros wrote:
>> Kevin,
>>
>> I gave a quick look at the issue. It seems that the High Speed USB H=
ost
>> module is kept in Software forced wakeup mode as a quick fix workaro=
und
>> to a bunch of silicon erratas. And we do nothing on USB global suspe=
nd.
>> That's why CORE does not hit retention.
>>
>> If we runtime_suspend the USB host module on USB global suspend then=
 it
>> will be put in Force Idle mode. This will allow CORE to hit retentio=
n
>> but then we will no longer be able to detect USB device connect even=
ts.
>>
>> So, till we have a better solution I will suggest to keep EHCI_HCD a=
s a
>> module in omap2plus_defconfig.
>
> I guess that "better solution" would be I/O pads wakeup interrupts ? =
But
> I don't think that's already in mainline, is it ?

I believe there was attempt to mainline that but it was rejected by Ton=
y:
http://marc.info/?l=3Dlinux-omap&m=3D134727428329745&w=3D2

Hopefully someone can come up with a suitable solution, not being able
to suspend and broken power saving with EHCI sucks :(

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
