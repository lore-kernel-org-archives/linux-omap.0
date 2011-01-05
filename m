From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v3 08/17] OMAP2,3: DSS2: Create platform_driver for each
 DSS HW IP
Date: Wed, 5 Jan 2011 18:55:37 +0530
Message-ID: <AANLkTikCUbyqwyhnqF9UDF2Nc9q6-EJqAaeHfjSkiwxM@mail.gmail.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
 <1294059069-26737-9-git-send-email-svadivu@ti.com> <1294226823.14254.51.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52044 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926Ab1AENZ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 08:25:58 -0500
Received: by mail-iy0-f171.google.com with SMTP id 21so16533484iyj.2
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:25:57 -0800 (PST)
In-Reply-To: <1294226823.14254.51.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Guruswamy Senthilvadivu <svadivu@ti.com>, paul@pwsan.com, khilman@deeprootsystems.com, a0919096@ti.com, linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Tomi,

On Wed, Jan 5, 2011 at 4:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
>> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>>
>> Hwmod adaptation design requires each of the DSS HW IP to be a platf=
orm driver.
>> Platform driver of dsshw has to be registered before of dispc, rfbi,=
 dsi1,
>> venc and omapdisplay driver should be after all the HW IPs. Sequence=
 it with
>> arch_initcall and device_initcall_sync.
>
> Do you know if there some extra meaning for the _sync initcalls? The
> name would imply something else that just init ordering.

[Sumit]:Looking at include/linux/init.h and some web-references [1]
[2] [3], our understanding is that all inits called via
device_initcall_sync() would be called later than the ones called by
device_initcall() in an SMP environment. [1] points to the patch for
enabling all probes on one level to finish before initcall for next
level are processed.

>
> I don't like using multiple initcall levels in the same driver. It's
> already quite complicated with omapdss, omapfb and the panel drivers.
> What were the dependencies here? Could we have just one initcall whic=
h
> would do the registration of platform drivers in the correct order?

[Sumit]: With this patchset, dss would have platform drivers for each
of the DSS h/w IPs - core would only do panel registration and s/w
inits (like dpi and sdi).
dispc, dss, rfbi, venc each of these are separate platform drivers
which will have their own init().

The idea was to order the inits like this: [bus, then h/w IPs, then s/w=
 blocks].

So,
omap_dss_bus_init first =3D> core_initcall()
then omap_dss for dss hw ip init =3D> arch_initcall()
then any of the other h/w IPs (dsi, rfbi, venc, dispc) in any order =3D=
>
device_initcall().

omap_display device in the end =3D> device_initcall_sync(); this would
also call s/w blocks init, and the panel devices. (this should wait
for all others to have finished).

omapfb is a lateinit call, so will happen after all other dss inits
have happened.

>
> Does this even work if the DSS is compiled as a module? I have the
> recollection that a module can only have one initcall, and in this ca=
se
> omapdss would have many.

[Sumit]: we haven't tried compiling DSS as module - I guess we will
have to create each dss hw IP also as a separate module.

About making one common initcall, then I think we would need to have
all platform_driver related functions either as global or in one file.
is this a better option than having each as a separate module?

I guess I will send the updated patch series once we agree on this. [I
have incorporated all other comments from Tony, Kevin and you on the
other patches].

Best regards,
~Sumit.
>
> =A0Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

[1]: http://readlist.com/lists/vger.kernel.org/linux-kernel/54/273365.h=
tml
[2]: http://www.webservertalk.com/archive242-2006-10-1713467.html
[3]: http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-01/msg11683.h=
tml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
