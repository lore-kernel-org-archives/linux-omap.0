From: Barry Song <21cnbao@gmail.com>
Subject: Re: Is Pandaboard cpuhotplug working stably?
Date: Wed, 21 Dec 2011 17:59:07 +0800
Message-ID: <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com>
 <20111221094624.GB3354@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58157 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab1LUJ73 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 04:59:29 -0500
Received: by eaad14 with SMTP id d14so1028707eaa.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Dec 2011 01:59:28 -0800 (PST)
In-Reply-To: <20111221094624.GB3354@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, yongsheng.liu@csr.com, linaro-dev <linaro-dev@lists.linaro.org>, peiyu.li@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, linux-arm-kernel@lists.infradead.org

2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Dec 21, 2011 at 05:23:48PM +0800, Barry Song wrote:
>> Hi guys,
>> i tried cpuhotplug on pandaboard for both
>> Pandroid_Froyo_L27.8.2_release_pkg and Linaro 11.11. It has failed t=
o
>> work stably.
>> On Pandroid_Froyo_L27.8.2_release_pkg, unplugging cpu1 works well:
>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>> CPU1: shutdown
>>
>> if i enable the cpu1 again by "echo 1 >
>> /sys/devices/system/cpu/cpu1/online", the system will restore to 3
>> random status: hang, normal, panic.
>>
>> Using =C2=A0Linaro 11.11 release, "echo 0 >
>> /sys/devices/system/cpu/cpu1/online" will make system hang and the
>> whole system will not be able to reset by pressing reset key, the on=
ly
>> way to reset system is pulling out AV power.
>>
>> i am sorry i can't get more time to debug and find more clues. just
>> want to ask people whether this is a version the cpuhotplug works
>> normal on?
>
> cpu hotplug is basically totally buggered - the preconditions placed
> upon the bringup code path are basically impossible to satisfy in any
> shape or form at the moment.
>
> There's the requirement that the secondary CPU is marked online and
> active before interrupts are enabled for the thread migration stuff
> to behave correctly. =C2=A0However, this is incompatible with smp_cal=
l_function()
> which will wait for online CPUs to respond to an IPI - which this one
> won't because interrupts are disabled.
>
> I think there was some discussion about how to fix this but I don't
> recall the details.

thanks, Russell. then could i think this is an ARM-kernel-specific bug
which exists on all ARM SMP chips for the moment?
and that bug doesn't happen on x86:
root@ubuntu:~/simple-rootfs/initrd/bin# echo 0 >
/sys/devices/system/cpu/cpu3/online
root@ubuntu:~/simple-rootfs/initrd/bin# echo 1 >
/sys/devices/system/cpu/cpu3/online
root@ubuntu:~/simple-rootfs/initrd/bin# echo 0 >
/sys/devices/system/cpu/cpu2/online
root@ubuntu:~/simple-rootfs/initrd/bin# echo 1 >
/sys/devices/system/cpu/cpu2/online

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
