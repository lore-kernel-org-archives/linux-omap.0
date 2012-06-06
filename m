From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] remoteproc: block premature rproc booting
Date: Tue, 05 Jun 2012 20:25:03 -0700
Message-ID: <4FCECD8F.8000600@codeaurora.org>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com> <4FBDFC4A.1060602@codeaurora.org> <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com> <4FCD276A.80505@codeaurora.org> <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/05/12 03:57, Ohad Ben-Cohen wrote:
> What about using a separate file for the resource table ?
>
> That should be very easy to support, and may make life easier for you
> in the long term.
>
> Resource tables tend to change in time, and hard coding it in the
> kernel doesn't sound ideal (both in terms of development overhead, and
> kernel-firmware backward and forward compatibility).

Thanks. I'll look into that as that seems feasible.

> Does the below work for you (sans the OMAP terminology ;) ?
>
> root@omap4430-panda:/sys/bus/platform/drivers/omap-rproc# echo
> omap-rproc.1 > unbind
> [  471.376556] remoteproc remoteproc0: releasing ipu_c0
> root@omap4430-panda:/sys/bus/platform/drivers/omap-rproc# echo
> omap-rproc.1 > bind
> [  478.219177] remoteproc remoteproc0: ipu_c0 is available
> [  478.224639] remoteproc remoteproc0: Note: remoteproc is still under
> development and considered experimental.
> [  478.235015] remoteproc remoteproc0: THE BINARY FORMAT IS NOT YET
> FINALIZED, and backward compatibility isn't yet guaranteed.
> [  478.325347] remoteproc remoteproc0: registered virtio0 (type 7)
> [  478.331848] remoteproc remoteproc0: registered virtio1 (type 3)
>
> This way user space can unbind a specific remote processor (which will
> also trigger unbinding the entire device hierarchy below it, i.e. all
> rpmsg/virtio devices).

This is great! I finally see how bind/unbind is useful.

What if I don't want to boot the device at kernel start-up? Do I have to
make it a module then?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
