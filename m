From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Wed, 29 Jun 2011 09:43:10 -0600
Message-ID: <BANLkTikJGHSwqMW2W2YA4EnvJ0yj+9C6ow@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com> <20110627222121.GD20865@ponder.secretlab.ca>
 <BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com> <BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
 <BANLkTi=16XEpvhWEAoUt_s5F41czeq2DVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=16XEpvhWEAoUt_s5F41czeq2DVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 28, 2011 at 5:00 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Wed, Jun 29, 2011 at 1:51 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> It's not the device_for_each_child() that you're 'putting' back from
>> here. =A0Its the original kref initialization when the device was
>> created.
>
> device_unregister() is already calling put_device(), doesn't that dea=
l
> with the original kref init for us ?

/me digs deeper:

device_register() has 2 parts; device_initialize() and device_add()
device_init() initialized the kref to 1 (via kobject_init()
device_add() calls get_device() to increment it to 2

Then similarly for device_unregister():
device_del() calls put_device() to decrement the kref to 1
a final put_device() call decrements the kref to 0 - which triggers a
call to the release method that kfrees the object.

So you are right that device_unregister drops the refcount to zero,
but the code still needs to be fixed to not call kfree() directly.

It also looks like rpmsg_destroy_channel() needs to be fixed to remove
the kfree call and an extra put_device() call.  This is important
because the last put_device() call above might /not/ decrement the
refcount to zero is for some reason something still holds a reference
to the device.  But the device will still get freed correctly when the
other holder finally calls device_put().

g.
