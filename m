From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Wed, 14 Sep 2011 21:38:43 +0300
Message-ID: <CAK=WgbY0zMkHw9XHDKPEfVQZVRfGP=nMmyJgm6jD5FEkBZkMRQ@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com> <87liwu8u3q.fsf@rustcorp.com.au>
 <BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=7TBMqnEf2qustrmSaubtTam79Bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>
List-Id: linux-omap@vger.kernel.org

Hi Rusty,

On Wed, Jun 22, 2011 at 1:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Wed, Jun 22, 2011 at 5:42 AM, Rusty Russell <rusty@rustcorp.com.au=
> wrote:
>> On Tue, 21 Jun 2011 10:18:33 +0300, Ohad Ben-Cohen <ohad@wizery.com>=
 wrote:
>>> +#define VIRTIO_ID_RPMSG =A0 =A0 =A0 =A0 =A0 =A0 =A010 /* virtio re=
mote processor messaging */
>>
>> I think you want 6. =A0Plan 9 jumped ahead to grab 9 :)
>
> 6 it is :)

Looking at the virtio-spec, it seems that 6 is taken by 'ioMemory'.
There's no indication for it in virtio_ids.h though, and the
virtio-spec has no appendix for this id, so maybe it's available after
all ?

If it is available, I'll take it for rpmsg, and will also update
virtio-spec appropriately. Otherwise, we'll settle on 7 ? :)

Thanks,
Ohad.
