From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Sun, 19 Sep 2010 16:45:19 +0200
Message-ID: <AANLkTin3J6E8e5uTPoomfcpvP1+t4-Svuah3Mv6Nj1Fc@mail.gmail.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com> <8F7AF80515AF0D4D93307E594F3CB40E4D79679E@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45092 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0ISOpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Sep 2010 10:45:39 -0400
Received: by iwn5 with SMTP id 5so3474557iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Sep 2010 07:45:39 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4D79679E@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Hari,

On Thu, Aug 12, 2010 at 12:44 AM, Kanigeri, Hari <h-kanigeri2@ti.com> w=
rote:
>> > +/* Attempt to acquire a spinlock once */
>> > +int hwspinlock_trylock(struct hwspinlock *handle)
>> > +{
>> > + =A0 =A0 =A0 int retval =3D 0;
>> > +
>> > + =A0 =A0 =A0 if (WARN_ON(handle =3D=3D NULL))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > +
>> > + =A0 =A0 =A0 if (WARN_ON(in_irq()))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> > +
>> > + =A0 =A0 =A0 if (pm_runtime_get(&handle->pdev->dev) < 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> > +
>> > + =A0 =A0 =A0 /* Attempt to acquire the lock by reading from it */
>> > + =A0 =A0 =A0 retval =3D readl(handle->lock_reg);
>> > +
>> > + =A0 =A0 =A0 if (retval =3D=3D HWSPINLOCK_BUSY)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(&handle->pdev->dev);
>> Any reason for using pm_runtime_put instead of pm_runtime_put_sync?
>>
>> Using pm_runtime_gett_sync & pm_runtime_put_sync have been recommend=
ed by
>> Kevin Hilman.
>
> Actually is there a need to call pm_runtime_put_sync for hwspinlock ?=
 Spinlocks are used by the co-processors and we have to ensure that the=
 device doesn't enter some low power mode without the knowledge of Co-p=
rocessor. I don't think run time PM is needed for hwspinlock.
>
> Just doing pm_runtime_get_sync at probe time for all the spinlock ins=
tances should be good.


It would probably make more sense to call pm_runtime_get_sync during
hwspinlock_request{_specific}, and then call pm_runtime_put during
hwspinlock_free.

This way the runtime PM's usage_count will reflect the number of locks
that are actually used, and if that number drops to (or never go
beyond) zero, it is desirable to have the hwspinlock's clock disabled.

This is also safe since no other core will use the hwspinlock if it
wasn't requested by the MPU beforehand (and if it does, we better know
about it and fix it).

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
