From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor messaging bus
Date: Tue, 28 Jun 2011 16:51:01 -0600
Message-ID: <BANLkTim+CemMz7A3J94e1UywCNd0r1SABQ@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com> <20110627222121.GD20865@ponder.secretlab.ca>
 <BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65112 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1F1WvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 18:51:21 -0400
In-Reply-To: <BANLkTikt08CDJiKNxGF2mKmOhyxHfv21_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>

On Tue, Jun 28, 2011 at 4:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Hi Grant,
>
> On Tue, Jun 28, 2011 at 1:21 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>>> +static int rpmsg_remove_device(struct device *dev, void *data)
>>> +{
>>> + =A0 =A0 struct rpmsg_channel *rpdev =3D to_rpmsg_channel(dev);
>>> +
>>> + =A0 =A0 device_unregister(dev);
>>> +
>>> + =A0 =A0 kfree(rpdev);
>>
>> put_device() I think.
>
> Don't think so, we get the device handle from device_for_each_child
> here, which doesn't call get_device (unlike device_find_child).

It's not the device_for_each_child() that you're 'putting' back from
here.  Its the original kref initialization when the device was
created.  Once a device is initialized, it must never be directly
kfree()'d.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
