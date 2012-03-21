From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: wake the device before ulpi transfers
Date: Wed, 21 Mar 2012 16:37:24 +0200
Message-ID: <CANOLnOM6tCiXuM+Zm5yFx7jd4JkN7JCLkndQ_2v_Z3D-Yi-sgg@mail.gmail.com>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
	<1328377432-13563-3-git-send-email-notasas@gmail.com>
	<20120321101030.GO3092@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120321101030.GO3092-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 21, 2012 at 12:10 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Sat, Feb 04, 2012 at 07:43:52PM +0200, Grazvydas Ignotas wrote:
>> musb can be suspended at the time some other driver wants to do ulpi
>> transfers using otg_io_* functions, and that can cause data abort,
>> as it happened with isp1704_charger:
>> http://article.gmane.org/gmane.linux.kernel/1226122
>>
>> Add pm_runtime to ulpi functions to rectify this. This also adds io_=
dev
>> to otg_transceiver so that pm_runtime can be used.
>>
>> Cc: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> doesn't apply, please refresh.

done.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
