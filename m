From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Wed, 22 Jun 2011 13:46:37 +0300
Message-ID: <BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com> <87liwu8u3q.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62956 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777Ab1FVKq6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 06:46:58 -0400
In-Reply-To: <87liwu8u3q.fsf@rustcorp.com.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>

On Wed, Jun 22, 2011 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.au> =
wrote:
> On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.com> =
wrote:
>> Add a virtio-based IPC bus, which enables kernel users to communicat=
e
>> with remote processors over shared memory using a simple messaging
>> protocol.
>
> Wow, sometimes one writes a standard and people use it. =A0Thanks!

And we really liked it: virtio_rpmsg_bus.c, the virtio driver which
does most of the magic here ended up pretty small thanks to virtio.
and the performance numbers are really good, too.

>> + =A0 =A0 /* Platform must supply pre-allocated uncached buffers for=
 now */
>> + =A0 =A0 vdev->config->get(vdev, VPROC_BUF_ADDR, &addr, sizeof(addr=
));
>> + =A0 =A0 vdev->config->get(vdev, VPROC_BUF_NUM, &num_bufs, sizeof(n=
um_bufs));
>> + =A0 =A0 vdev->config->get(vdev, VPROC_BUF_SZ, &buf_size, sizeof(bu=
f_size));
>> + =A0 =A0 vdev->config->get(vdev, VPROC_BUF_PADDR, &vrp->phys_base,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 sizeof(vrp->phys_base));
>
> The normal way is to think of the config space as a structure, and us=
e
> offsets rather than using an enum value to distinguish the fields.

Yes, I was (mis-)using the config space for now to talk with
platform-specific code (on the host), and not with the peer, so I
opted for simplicity.

But this is definitely one thing that is going away: I don't see any
reason why not just use dma_alloc_coherent (or even dma_pool_create)
directly from the driver here in order to get those buffers.

>> +#define RPMSG_NAME_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
32
>> +#define RPMSG_DEVICE_MODALIAS_FMT =A0 =A0"rpmsg:%s"
>> +
>> +struct rpmsg_device_id {
>> + =A0 =A0 char name[RPMSG_NAME_SIZE];
>> + =A0 =A0 kernel_ulong_t driver_data =A0 =A0 =A0/* Data private to t=
he driver */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __attribute__((aligned(siz=
eof(kernel_ulong_t))));
>> +};
>
> This alignment directive seems overkill...

Yes, looks like I can remove this. thanks.

>> +#define VIRTIO_ID_RPMSG =A0 =A0 =A0 =A0 =A0 =A0 =A010 /* virtio rem=
ote processor messaging */
>
> I think you want 6. =A0Plan 9 jumped ahead to grab 9 :)

6 it is :)

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
