From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 14:51:28 -0400
Message-ID: <AANLkTin+SRBdSuHihTLY7ifErXV7ANAQxKLOxej1wX8R@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E700C63@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab0HKSva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:51:30 -0400
Received: by wyb32 with SMTP id 32so449429wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 11:51:28 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E700C63@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uppal, Deepali" <deepali@ti.com>
Cc: Hari Kanigeri <hari.kanigeri@gmail.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

Hi Deepali,

On Wed, Aug 11, 2010 at 9:48 AM, Uppal, Deepali <deepali@ti.com> wrote:
> Hello Ben,
>
> I am Deepali, DSPLink engineering manager from DSPLink team in TI Ind=
ia. I have removed the linux omap mailing list as my mailing client is =
not correctly setup to send mails to community. I will respond to the c=
ommunity mailing list later.

Thank you for reading and replying.

Note to the list: With his permission, I am replying on-list with
Deepali's reply in-line.

> To answer your questions:
> 1) Specifying shared memory for DSPLink does involve setting aside me=
mory for Linux using the mem variable in kernel bootargs.
>
> 2) DSPLink does not support dynamic linking and loading. All the DSP =
code must be available in the DSP image loaded at PROC_load API time it=
self.

Thank you for confirming these points.

> 3) There are no plans of putting DSPLink (which is currently availabl=
e into mainstream kernel). However there are plans of putting the next =
generation of DSPLink for newer generation of devices onto the communit=
y. But this may be too late for your needs. However we do support build=
 against the git kernels in the newer versions of DSPLink.

This is good news, Deepali. Are there any current DSPLink interfaces
that are guaranteed to be stable into the 'next generation' ?

You also make a good point that the ARM-side DSPLink component is an
out-of-tree kernel module which builds against recent kernels. This is
great support for us developers that are using very recent kernels and
I think that it is a valuable feature that you have provided with
DSPLink. Thanks for that.

> Information about DSPLink is available at http://processors.wiki.ti.c=
om/index.php/Category:DSPLink
>
> DSPLink Webex trainings are at http://processors.wiki.ti.com/index.ph=
p/DSPBIOS_LINK_WebEx_Presentations
>
> To give a brief overview:
> DSPLink provides foundation software for the inter-processor communic=
ation =A0i.e. IPC across the GPP-DSP boundary. It differs from DSPBridg=
e that it does not provide any framework infrastructure but focuses mor=
e on the IPC. It does provide support for Codec Engine which is a codec=
s management framework which sits on top of DSPLink.

I think that Hari Kanigeri points it out in his later post; it sounds
like I am trying to compare apples and oranges by comparing dspbrige
and DSP Link. Would a more equatable comparison be between Codec
Engine + DSP Link vs. dspbridge?

> DSPLink provides
> =A0 =A0* PROC: Boot Loading of DSP

It is this feature category where it seems that DSP Link falls short
of the features afforded by dspbridge. But I'm started to see that
this because DSPLink alone is not intended to be feature complete
here. When combined with Code Engine is it possible to get dynamic
memory management and dynamic application loading ?

> =A0 =A0* Inter-Processor Communication protocols
> =A0 =A0 =A0 =A0 =A0o Complete protocols for different types of data t=
ransfer between the processors
> =A0 =A0 =A0 =A0 =A0o Each protocol meets a different data transfer ne=
ed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ MSGQ: Message Queue
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ CHNL: SIO/streaming based on issue-r=
eclaim model
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ RingIO: Circular ring buffer based d=
ata streaming
> =A0 =A0* Inter-Processor Communication building blocks
> =A0 =A0 =A0 =A0 =A0o Low-level building blocks used by the protocols
> =A0 =A0 =A0 =A0 =A0o Each building block is also exposed as APIs to a=
llow framework writers to define their own application-specific protoco=
ls
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ POOL: Memory Manager: shared/non-sha=
red
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ NOTIFY: Interrupt abstraction and de=
-multiplexing for notification of user events
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ MPCS: Multi-processor critical secti=
on for mutually exclusive access to shared objects
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ MPLIST: Multi-processor doubly linke=
d circular list
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+ PROC_read/PROC_write: Read from or w=
rite to DSP memory
>
> DSPLink is also available on different OS (WinCE and PrOS) and platfo=
rms (DM6446, DM6467 etc) combinations. This enables to you port your ap=
plication to any other platform OS combination seamlessly.

DSPLink+Codec Engine is also portable across all recent DaVinci and
OMAP platforms correct? This is itself an attractive feature.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
