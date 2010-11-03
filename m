From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP3 low power mode broken on l-o
Date: Wed, 3 Nov 2010 13:48:56 +0100
Message-ID: <AANLkTimucOpcrMoCytiSbrNevrNAtErpxCEUL=AF5zce@mail.gmail.com>
References: <AANLkTikzVLW08MrZUPWmVx6+w4E8sXN5NHwM1R7Ya8zX@mail.gmail.com>
	<87sjzjetfy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57349 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab0KCMs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 08:48:57 -0400
Received: by gxk23 with SMTP id 23so434400gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Nov 2010 05:48:57 -0700 (PDT)
In-Reply-To: <87sjzjetfy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Tue, Nov 2, 2010 at 2:38 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> The low power mode on the latest l-o master branch is broken, so I
>> investigated a bit. Here are the results. This has been tested on
>> OMAP3EVM and Beagleboard.
>>
>> The problem is that the CORE does not reach the desired mode (RET,
>> OFF). It is caused by the I2C1 fclk that is left enabled at suspend
>> time.
>> Extra printks has been added in the clock enable and disable functio=
ns
>> for I2C and a stack dump has been added in the suspend path if the
>> clock is still enabled, cf. log below.
>>
>> In the devices suspend sequence the RTC gets suspended, which trigge=
rs
>> a read of the TWL RTC through the I2C bus, which in turn enables the
>> I2C1 fclk. That clock is only disabled on devices resume.
>>
>> I am guessing this is linked to the recent changes in the I2C for HW=
MOD support.
>> What is the correct fix to have the I2C modules correctly shut off
>> before the suspend?
>
> I2C clocks are supposed to be disabled after each transaction. =A0Thi=
s
> isn't happening.
>
> My guess is that the 'put' that happens after TX doesn't actually
> actually result in a call to omap_device_idle() since system suspend =
is
> active. =A0Static suspend/resume take the runtime PM lock, effectivel=
y
> disabling runtime PM suspend during static suspend.
>
> I have a patch/workaround for this problem which is part of my pm-cor=
e
> branch, but I did not submit for 2.6.37 as I'm not entirely convinced=
 of
> it yet. =A0Basically, in the OMAP bus-methods for static suspend/resu=
me I
> tinker with the runtime PM usecounting such that the devices can idle=
=2E
>
> Please take a look at the tip patch in my pm-suspend branch, try it o=
ut
> and see if it fixes your problem.
Indeed the patch fixes the problem. The pm_runtime_get/put_sync
methods are correctly called for I2C and so the low power mode is hit.

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
